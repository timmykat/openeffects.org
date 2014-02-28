class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :version, index: true
      t.string :status, index: true
      t.boolean :current, index: true

      t.timestamps
    end
  end
end
