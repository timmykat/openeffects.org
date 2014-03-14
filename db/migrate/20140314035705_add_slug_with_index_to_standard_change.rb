class AddSlugWithIndexToStandardChange < ActiveRecord::Migration
  def change
    add_column :standard_changes, :slug, :string
    add_index :standard_changes, :slug, unique: true
  end
end
