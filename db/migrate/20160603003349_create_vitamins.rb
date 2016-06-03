class CreateVitamins < ActiveRecord::Migration
  def change
    create_table :vitamins do |t|
      t.references :intake, index: true, foreign_key: true
      t.integer :vitamin_c_mg
      t.integer :thiamin_mg
      t.integer :riboflavin_mg
      t.integer :niacin_mg
      t.integer :vitamin_b_6_mg
      t.integer :folate_dfe_μg
      t.integer :vitamin_b_12_μg
      t.integer :vitamin_a_rae_μg
      t.integer :vitamin_a_iu
      t.integer :vitamin_e_mg
      t.integer :vitamin_d_μg
      t.integer :vitamin_d_iu
      t.integer :vitamin_k_μg

      t.timestamps null: false
    end
  end
end
