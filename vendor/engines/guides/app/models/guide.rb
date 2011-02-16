class Guide < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true

  acts_as_indexed :fields => [:title, :description, :guide, :author, :category]

  validates_presence_of :title
  validates_uniqueness_of :title

  def categories
    categories = []
    
    HTTParty.get('http://github.com/api/v2/json/tree/show/stevenheidel/refinerycms/070c69dc9f99ea09ccdeb6242fbd8e77a9359941')['tree'].each do |folder|
      categories << folder['name']
    end
    
    categories
  end
  
  def refresh_github
    Guide.delete_all
    
    HTTParty.get('http://github.com/api/v2/json/tree/show/stevenheidel/refinerycms/070c69dc9f99ea09ccdeb6242fbd8e77a9359941')['tree'].each do |folder|
      category = folder['name']
      
      HTTParty.get("http://github.com/api/v2/json/tree/show/stevenheidel/refinerycms/#{folder['sha']}")['tree'].each do |file|
        title = file['name']
        guide = HTTParty.get("http://github.com/api/v2/json/blob/show/stevenheidel/refinerycms/#{file['sha']}")
        
        authors = []
        HTTParty.get("http://github.com/api/v2/json/commits/list/stevenheidel/refinerycms/master/doc/guides/#{folder['name'].gsub(" ", "%20")}/#{file['name'].gsub(" ", "%20")}")['commits'].each do |commit|
          authors << commit['author']['name']
        end
        author = authors.uniq.join(", ")
        
        Guide.create(:title => title, :description => nil, :guide => guide, :author => author, :category => category)
      end
    end
  end
  
  def url
    "http://refinerycms.com/guides/#{self.to_param}"
  end

end
