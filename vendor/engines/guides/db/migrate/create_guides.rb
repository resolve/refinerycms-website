class CreateGuides < ActiveRecord::Migration

  def self.up
    create_table :guides do |t|
      t.string :title
      t.text :description
      t.text :guide
      t.string :author
      t.string :category
      t.integer :position

      t.timestamps
    end

    add_index :guides, :id

    load(Rails.root.join('db', 'seeds', 'guides.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "guides"})

    Page.delete_all({:link_url => "/guides"})

    drop_table :guides
  end

end
