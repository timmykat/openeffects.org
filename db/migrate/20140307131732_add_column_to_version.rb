class AddColumnToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :committee, :text
  end
end
