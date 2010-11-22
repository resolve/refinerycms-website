class CreateTutorials < ActiveRecord::Migration

  def self.up
    create_table :tutorials do |t|
      t.string :title
      t.string :category
      t.string :author
      t.text :content
      t.boolean :draft
      t.integer :position

      t.timestamps
    end

    add_index :tutorials, :id

    load(Rails.root.join('db', 'seeds', 'tutorials.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "tutorials"})

    Page.delete_all({:link_url => "/tutorials"})

    drop_table :tutorials
  end

end
