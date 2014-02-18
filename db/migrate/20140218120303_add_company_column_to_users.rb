class AddCompanyColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_index  :users, :company
  end
end
