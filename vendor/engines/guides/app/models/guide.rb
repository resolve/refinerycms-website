class Guide < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true

  acts_as_indexed :fields => [:title, :description, :guide, :author, :category]

  validates_presence_of :title
  validates_uniqueness_of :title

  def self.categories
    if (categories = RefinerySetting.get(:categories, :scoping => :guides)).blank?
      self.refresh_github!
      categories = RefinerySetting.get(:categories, :scoping => :guides)
    end

    categories
  end

  # TODO: Find this out automatically
  REPO = "resolve/refinerycms"

  def self.refresh_github!
    blobs = HTTParty.get("http://github.com/api/v2/json/blob/full/#{REPO}/master")['blobs']
    blobs.reject!{|b| b['name'] !~ %r{^doc/guides/}}

    guides = []
    blobs.each do |blob|
      folder_name = blob['name'].to_s.split('/')[-2]

      authors = []
      blob_url = "http://github.com/api/v2/json/commits/list/#{REPO}/master/#{blob['name'].to_s.gsub(" ", "%20")}"
      HTTParty.get(blob_url)['commits'].each do |commit|
        authors << commit['author']['name']
      end
      author = authors.uniq.join(", ")

      title = blob['name'].to_s.split('/').last
      guide = HTTParty.get("http://github.com/api/v2/json/blob/show/#{REPO}/#{blob['sha']}")
      github_url = "/blob/master/#{blob['name'].to_s.gsub(' ', '%20')}"
      guides << Guide.new({
        :title => title.split(' - ').last.split('.textile').first,
        :description => (guide.scan(/^(.*)endprologue\./m).flatten.first.split("\n\n")[1..-1].join("\n\n") rescue nil),
        :guide => guide,
        :author => author,
        :category => folder_name,
        :position => (title.split(' - ').first.to_i rescue Guide.maximum(:position)),
        :github_url => github_url
      })
    end

    # All save, or none save.
    ActiveRecord::Base.transaction do
      RefinerySetting.set(:categories, {
        :value => blobs.map{|b| b['name'].split('/')[-2]}.uniq,
        :scoping => :guides
      })

      # Delete all existing guides and their slugs
      Guide.delete_all
      Slug.delete_all(:sluggable_type => 'Guide')

      # Now, save all the guides and return their titles so we can visually see.
      guides.map do |guide|
        guide.save
        guide.title
      end
    end

    Rails.cache.delete_matched(/.*guides.*/)
    expire_page(:controller => 'guides', :action => 'index')
    expire_page(:controller => 'guides', :action => 'show')
  end

  def url
    "http://refinerycms.com/guides/#{self.to_param}"
  end

end
