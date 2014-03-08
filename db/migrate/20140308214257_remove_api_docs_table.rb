class RemoveApiDocsTable < ActiveRecord::Migration
  def change
    drop_table :api_docs
  end
end
