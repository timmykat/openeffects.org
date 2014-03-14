class AddActiveToHomeHero < ActiveRecord::Migration
  def change
    add_column :home_heros, :active, :boolean
  end
end
