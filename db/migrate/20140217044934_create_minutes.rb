class CreateMinutes < ActiveRecord::Migration
  def change
    create_table :minutes do |t|
      t.string :meeting, :null => false, :default => ""
      t.date :date
      t.string :location
      t.text :members
      t.text :observing
      t.text :minutes

      t.timestamps
    end
    
    add_index :minutes, :date
    add_index :minutes, :meeting
  end
end
