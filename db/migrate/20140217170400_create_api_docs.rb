class CreateApiDocs < ActiveRecord::Migration
  def change
    create_table :api_docs do |t|
      t.string :version
      t.date :date
      t.text :content
      t.boolean :published
      t.boolean :current

      t.timestamps
    end
  end
end
