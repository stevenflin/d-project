class CreateCreators < ActiveRecord::Migration[5.0]
  def change
    create_table :creators do |t|
      t.string :name
      t.string :propic
      t.string :link
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
