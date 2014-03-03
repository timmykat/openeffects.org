class AddDefaultValueForPublished < ActiveRecord::Migration
  def change
    change_column :contents, :published, :boolean, :default => false
    change_column :minutes, :published, :boolean, :default => false
    change_column :news_items, :published, :boolean, :default => false
  end
end
