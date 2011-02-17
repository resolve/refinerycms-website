class AddGuides < ActiveRecord::Migration
  def self.up
    drop_table :tutorials

    create_table "guides", :force => true do |t|
      t.string   "title"
      t.text     "description"
      t.text     "guide"
      t.string   "author"
      t.string   "category"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "guides", ["id"], :name => "index_guides_on_id"
  end

  def self.down
  end
end