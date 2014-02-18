class RenameUserColumnInCompanies < ActiveRecord::Migration
  def change
    rename_column :companies, :user_id, :contact_id
  end
end
