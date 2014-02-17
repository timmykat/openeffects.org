class CreateCompanies < ActiveRecord::Migration
  def change
    create_table(:companies) do |t|
      t.string :name, :null => false, :default => ""
      t.text :description
      t.string :url
      t.references :user
      t.text :address
      t.date :joined
      t.attachment :logo

      t.timestamps
    end
  end
end
