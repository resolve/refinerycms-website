class Guide < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true

  acts_as_indexed :fields => [:title, :description, :guide, :author, :category]

  validates_presence_of :title
  validates_uniqueness_of :title

  CATEGORIES = [
    'Getting Started',
    'Documentation',
    'Essentials',
    'Customising your Design',
    'Extending with Engines',
    'Updating Refinery',
    'Hosting',
    'Translating',
    'Tips and Tricks'
  ]

  def url
    "http://refinerycms.com/guides/#{self.to_param}"
  end

end
