class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :identifier
      t.string :title
      t.text :content
      t.attachment :image
      t.attachment :pdf

      t.timestamps
    end
    
    add_index :contents, :identifier
    add_index :contents, :title
  end
end
