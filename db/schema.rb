# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150625220946) do

  create_table "blog_categories", :force => true do |t|
    t.string   "title",       :limit => 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_slug", :limit => 510
  end

  create_table "blog_categories_blog_posts", :id => false, :force => true do |t|
    t.integer "blog_category_id"
    t.integer "blog_post_id"
  end

  create_table "blog_comments", :force => true do |t|
    t.integer  "blog_post_id"
    t.boolean  "spam"
    t.string   "name",         :limit => 510
    t.string   "email",        :limit => 510
    t.text     "body"
    t.string   "state",        :limit => 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_posts", :force => true do |t|
    t.string   "title",         :limit => 510
    t.text     "body"
    t.boolean  "draft"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "cached_slug",   :limit => 510
    t.string   "custom_url",    :limit => 510
    t.text     "custom_teaser"
  end

  create_table "guides", :force => true do |t|
    t.string   "title",       :limit => 510
    t.text     "description"
    t.text     "guide"
    t.string   "author",      :limit => 510
    t.string   "category",    :limit => 510
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_url",  :limit => 510
    t.string   "branch",      :limit => 510
  end

  create_table "images", :force => true do |t|
    t.string   "image_mime_type", :limit => 510
    t.string   "image_name",      :limit => 510
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_uid",       :limit => 510
    t.string   "image_ext",       :limit => 510
  end

  create_table "inquiries", :force => true do |t|
    t.string   "name",       :limit => 510
    t.string   "email",      :limit => 510
    t.string   "phone",      :limit => 510
    t.text     "message"
    t.integer  "position"
    t.boolean  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "spam"
  end

  create_table "inquiry_settings", :force => true do |t|
    t.string   "name",        :limit => 510
    t.text     "value"
    t.boolean  "destroyable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_part_translations", :force => true do |t|
    t.integer  "page_part_id"
    t.string   "locale",       :limit => 510
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_parts", :force => true do |t|
    t.integer  "page_id"
    t.string   "title",      :limit => 510
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale",       :limit => 510
    t.string   "title",        :limit => 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_title", :limit => 510
  end

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "position"
    t.string   "path",                :limit => 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_in_menu"
    t.string   "link_url",            :limit => 510
    t.string   "menu_match",          :limit => 510
    t.boolean  "deletable"
    t.string   "custom_title_type",   :limit => 510, :default => "none"
    t.boolean  "draft"
    t.boolean  "skip_to_first_child"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "refinery_settings", :force => true do |t|
    t.string   "name",                    :limit => 510
    t.text     "value"
    t.boolean  "destroyable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scoping",                 :limit => 510
    t.boolean  "restricted"
    t.string   "callback_proc_as_string", :limit => 510
    t.string   "form_value_type",         :limit => 510
  end

  create_table "resources", :force => true do |t|
    t.string   "file_mime_type", :limit => 510
    t.string   "file_name",      :limit => 510
    t.integer  "file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_uid",       :limit => 510
    t.string   "file_ext",       :limit => 510
  end

  create_table "roles", :force => true do |t|
    t.string "title", :limit => 510
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type",    :limit => 510
    t.string   "browser_title",    :limit => 510
    t.string   "meta_keywords",    :limit => 510
    t.text     "meta_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name",           :limit => 510
    t.integer  "sluggable_id"
    t.integer  "sequence",                      :default => 1, :null => false
    t.string   "sluggable_type", :limit => 80
    t.string   "scope",          :limit => 80
    t.datetime "created_at"
    t.string   "locale",         :limit => 510
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "slugs_name_sluggable_type_scope_sequence_key", :unique => true

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", :limit => 510
    t.integer  "tagger_id"
    t.string   "tagger_type",   :limit => 510
    t.string   "context",       :limit => 510
    t.datetime "created_at"
  end

  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string  "name",           :limit => 510
    t.integer "taggings_count",                :default => 0
  end

  create_table "user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name",     :limit => 510
    t.integer "position"
  end

  add_index "user_plugins", ["user_id", "name"], :name => "user_plugins_user_id_name_key", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",             :limit => 510, :null => false
    t.string   "email",                :limit => 510, :null => false
    t.string   "encrypted_password",   :limit => 510, :null => false
    t.string   "persistence_token",    :limit => 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",     :limit => 510
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",   :limit => 510
    t.string   "last_sign_in_ip",      :limit => 510
    t.integer  "sign_in_count"
    t.string   "remember_token",       :limit => 510
    t.string   "reset_password_token", :limit => 510
    t.datetime "remember_created_at"
  end

end
