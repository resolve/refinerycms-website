class Guide < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true

  acts_as_indexed :fields => [:title, :description, :guide, :author, :category]

  validates_presence_of :title
  validates_uniqueness_of :title

  def self.categories
    if (categories = RefinerySetting.get(:categories, :scoping => :guides)).blank?
      self.refresh_github
    end
    
    categories
  end

  # TREE is the SHA identifier of the tree at REPO and in folder LOCATION on the master branch
  # TODO: Find this out automatically
  TREE = "070c69dc9f99ea09ccdeb6242fbd8e77a9359941"
  REPO = "stevenheidel/refinerycms"
  LOCATION = "doc/guides"
  
  def self.refresh_github
    categories = []
    guides = []

    HTTParty.get("http://github.com/api/v2/json/tree/show/#{REPO}/#{TREE}")['tree'].each do |folder|
      category = folder['name']
      categories << category

      HTTParty.get("http://github.com/api/v2/json/tree/show/#{REPO}/#{folder['sha']}")['tree'].each do |file|
        title = file['name'].to_s
        guide = HTTParty.get("http://github.com/api/v2/json/blob/show/#{REPO}/#{file['sha']}")

        authors = []
        HTTParty.get("http://github.com/api/v2/json/commits/list/#{REPO}/master/#{LOCATION}/#{folder['name'].gsub(" ", "%20")}/#{file['name'].gsub(" ", "%20")}")['commits'].each do |commit|
          authors << commit['author']['name']
        end
        author = authors.uniq.join(", ")

        guides << Guide.new({
          :title => title.split(' - ').last.split('.textile').first,
          :description => (guide.scan(/^(.*)endprologue\./m).flatten.first.split("\n\n")[1..-1].join("\n\n") rescue nil),
          :guide => guide,
          :author => author,
          :category => category,
          :position => (title.split(' - ').first.to_i rescue Guide.maximum(:position))
        })
      end
    end
    
    RefinerySetting.set(:categories, {:value => categories, :scoping => :guides})
    
    Guide.delete_all
    guides.map {|guide| guide.save}
  end

  def url
    "http://refinerycms.com/guides/#{self.to_param}"
  end

end
