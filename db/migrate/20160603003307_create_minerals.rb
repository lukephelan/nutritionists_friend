class CreateMinerals < ActiveRecord::Migration
  def change
    create_table :minerals do |t|
      t.references :intake, index: true, foreign_key: true
      t.integer :calcium_mg
      t.integer :iron_mg
      t.integer :magnesium_mg
      t.integer :phosphorus_mg
      t.integer :potassium_mg
      t.integer :sodium_mg
      t.integer :zinc_mg

      t.timestamps null: false
    end
  end
end
