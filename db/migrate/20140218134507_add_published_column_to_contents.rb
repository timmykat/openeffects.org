class AddPublishedColumnToContents < ActiveRecord::Migration
  def change
    add_column :contents, :published, :boolean
    add_index :contents, :published
  end
end
