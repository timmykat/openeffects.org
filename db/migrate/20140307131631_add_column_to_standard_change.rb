class AddColumnToStandardChange < ActiveRecord::Migration
  def change
    add_reference :standard_changes, :sponsor, index: true
  end
end
