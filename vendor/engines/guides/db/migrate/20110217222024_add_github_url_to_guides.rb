class AddGithubUrlToGuides < ActiveRecord::Migration
  def self.up
    add_column :guides, :github_url, :string
  end

  def self.down
    remove_column :guides, :github_url
  end
end
