class CreateJoinTable2 < ActiveRecord::Migration[5.0]
  def change
    create_join_table :brands, :creators do |t|
      t.index [:brand_id, :creator_id]
      t.index [:creator_id, :brand_id]
    end
  end
end
