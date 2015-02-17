class AddArchivedColumnToStandardChanges < ActiveRecord::Migration
  def change
    add_column :standard_changes, :archived, :boolean, default: false
    add_index :standard_changes, :archived
  end
end
