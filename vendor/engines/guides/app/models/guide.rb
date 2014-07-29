class Guide < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true, :scope => :branch

  acts_as_indexed :fields => [:title, :description, :guide, :author, :category]

  validates_presence_of :title
  # Guides can have the same title on different branches.
  # validates_uniqueness_of :title

  def self.categories(branch)
    branch ||= Guide::BRANCH
    if (categories = RefinerySetting.get(:"categories_for_#{branch.to_s.underscore}", :scoping => :guides)).blank?
      refresh_github!(:branch => branch)
      categories = RefinerySetting.get(:"categories_for_#{branch.to_s.underscore}", :scoping => :guides)
    end

    categories
  end

  # TODO: Find this out automatically
  REPO = "refinery/refinerycms"
  BRANCH = "2-1-stable"
  BRANCHES = %w(2-1-stable 2-0-stable 1-0-stable master)
  TOKEN = "897191e0ba196cabe8b667a0b5ef009ac40a7dc9" # a nice read only token
  HEADERS = {:headers => {'User-Agent' => 'HTTParty', 'Authorization' => "token #{TOKEN}"}}

  def self.refresh_github!(options = {})
    options = {:branch => BRANCH, :repo => REPO}.merge(options)
    tree_url = "https://api.github.com/repos/#{options[:repo]}/git/trees/#{options[:branch]}?recursive=true"
    trees = HTTParty.get(tree_url, HEADERS)['tree']
    trees.reject!{|b| b['path'] !~ %r{^doc/guides/}}
    trees.reject!{|b| b['path'] !~ %r{.textile$}}

    guides = []
    trees.each do |blob|
      name = blob['path']
      folder_name = name.to_s.split('/')[-2]

      # authors = []
      # blob_url = "https://api.github.com/repos/#{options[:repo]}/commits/#{options[:branch]}/#{name.to_s.gsub(" ", "%20")}"
      # HTTParty.get(blob_url, HEADERS)['commits'].each do |commit|
      #   authors << commit['author']['name']
      # end
      # author = authors.uniq.join(", ")

      title = name.to_s.split('/').last
      content_url = "https://api.github.com/repos/#{options[:repo]}/git/blobs/#{blob['sha']}"
      guide = Base64::decode64(
        HTTParty.get(content_url, HEADERS)['content'].to_s
      )
      github_url = "/blob/#{options[:branch]}/#{name.to_s.gsub(' ', '%20')}"
      guides << Guide.new({
        :title => title.split(' - ').last.split('.textile').first,
        :description => (guide.scan(/^(.*)endprologue\./m).flatten.first.split("\n\n")[1..-1].join("\n\n") rescue nil),
        :guide => guide,
#        :author => author,
        :category => folder_name,
        :position => (title.split(' - ').first.to_i rescue Guide.maximum(:position)),
        :github_url => github_url,
        :branch => options[:branch]
      })
      $stdout.puts "Added guide with title #{guides.last.title}"
    end

    # All save, or none save.
    ActiveRecord::Base.transaction do
      RefinerySetting.set(:"categories_for_#{options[:branch].to_s.underscore}", {
        :value => trees.map{|b| b['path'].split('/')[-2]}.uniq,
        :scoping => :guides
      })

      # Delete all existing guides and their slugs
      guide_ids = Guide.where(:branch => options[:branch]).select('id')
      Guide.delete_all(:branch => options[:branch])
      Slug.delete_all(:sluggable_type => 'Guide', :scope => options[:branch])

      # Now, save all the guides and return their titles so we can visually see.
      guides.map do |guide|
        guide.save
        guide.title
      end
    end

    Rails.cache.delete_matched(/.*guides.*/)
    if (guides_dir = Rails.root.join('public', 'guides')).directory?
      $stdout.puts "Clearing cached guides directory #{guides_dir}"
      guides_dir.rmtree
    end
    if (guides_file = Rails.root.join('public', 'guides.html')).file?
      $stdout.puts "Clearing cached #{guides_file.split.last}"
      guides_file.delete
    end
    if (edge_guides_file = Rails.root.join('public', 'edge-guides.html')).file?
      $stdout.puts "Clearing cached #{edge_guides_file.split.last}"
      edge_guides_file.delete
    end
    if (homepage = Rails.root.join('public', 'index.html')).file?
      $stdout.puts "Clearing the homepage due to Github push."
      homepage.delete
    end

    guides
  end

  def url
    "http://refinerycms.com/#{"edge-" if self.branch == 'master'}guides/#{self.to_param}"
  end

end
