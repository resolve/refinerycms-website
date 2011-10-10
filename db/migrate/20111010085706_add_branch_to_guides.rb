class AddBranchToGuides < ActiveRecord::Migration
  def self.up
    add_column :guides, :branch, :string

    Guide.reset_column_information

    Guide.update_all(:branch => Guide::BRANCH)
  end

  def self.down
    Guide.delete_all(Guide.arel_table[:branch].not_eq(Guide::BRANCH))

    remove_column :guides, :branch
  end
end
