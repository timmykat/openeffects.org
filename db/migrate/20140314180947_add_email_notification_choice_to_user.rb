class AddEmailNotificationChoiceToUser < ActiveRecord::Migration
  def change
    add_column :users, :notifications, :boolean
    add_index :users, :notifications
  end
end
