class AddPublishedColumnToMinutes < ActiveRecord::Migration
  def change
    add_column :minutes, :published, :boolean
    add_index :minutes, :published
  end
end
