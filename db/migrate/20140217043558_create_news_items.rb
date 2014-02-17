class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :headline, :null => false, :default => ""
      t.date :date
      t.text :summary, :null => false
      t.boolean :published, :default => false

      t.timestamps
    end
    add_index :news_items, :date
    add_index :news_items, :headline
    add_index :news_items, :published
  end
end
