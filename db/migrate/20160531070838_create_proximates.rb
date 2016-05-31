class CreateProximates < ActiveRecord::Migration
  def change
    create_table :proximates do |t|
      t.references :intake, index: true, foreign_key: true
      t.integer :water_g
      t.integer :energy_kcal
      t.integer :protein_g
      t.integer :total_fat_g
      t.integer :carbohydrate_g
      t.integer :total_dietary_fibre_g
      t.integer :total_sugar_g

      t.timestamps null: false
    end
  end
end
