class AddColumntoStandardChange < ActiveRecord::Migration
  def change
    add_column :standard_changes, :discussion, :text
  end
end
