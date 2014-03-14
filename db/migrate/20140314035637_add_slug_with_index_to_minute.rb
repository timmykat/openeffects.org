class AddSlugWithIndexToMinute < ActiveRecord::Migration
  def change
    add_column :minutes, :slug, :string
    add_index :minutes, :slug, unique: true
  end
end
