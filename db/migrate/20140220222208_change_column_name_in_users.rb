class ChangeColumnNameInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :company, :company_or_org
  end
end
