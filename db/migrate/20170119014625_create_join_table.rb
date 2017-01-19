class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :agencies, :creators do |t|
      t.index [:agency_id, :creator_id]
      t.index [:creator_id, :agency_id]
    end
  end
end
