class CreateHomeHeros < ActiveRecord::Migration
  def change
    create_table :home_heros do |t|
      t.attachment :hero_image

      t.timestamps
    end
  end
end
