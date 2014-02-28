class CreateStandardChanges < ActiveRecord::Migration
  def change
    create_table :standard_changes do |t|
      t.references :version, index: true
      t.text :committee
      t.string :title, index: true
      t.string :type, index: true
      t.string :status, index: true
      t.text :status_details
      t.text :overview
      t.text :solution
      
      t.timestamps
    end
  end
end
