class Guide < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :description, :guide, :author, :category]
  
  validates_presence_of :title
  validates_uniqueness_of :title
  
  CATEGORIES = ['Getting Started', 'Beginner', 'Intermediate', 'Advanced']
  
end