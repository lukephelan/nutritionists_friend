class ChangeColumnsToDecimal < ActiveRecord::Migration
  def change
    change_column :proximates, :water_g, :decimal
    change_column :proximates, :energy_kcal, :decimal
    change_column :proximates, :protein_g, :decimal
    change_column :proximates, :total_fat_g, :decimal
    change_column :proximates, :carbohydrate_g, :decimal
    change_column :proximates, :total_dietary_fibre_g, :decimal
    change_column :proximates, :total_sugar_g, :decimal
    change_column :minerals, :calcium_mg, :decimal
    change_column :minerals, :iron_mg, :decimal
    change_column :minerals, :magnesium_mg, :decimal
    change_column :minerals, :phosphorus_mg, :decimal
    change_column :minerals, :potassium_mg, :decimal
    change_column :minerals, :sodium_mg, :decimal
    change_column :minerals, :zinc_mg, :decimal
    change_column :vitamins, :vitamin_c_mg, :decimal
    change_column :vitamins, :thiamin_mg, :decimal
    change_column :vitamins, :riboflavin_mg, :decimal
    change_column :vitamins, :niacin_mg, :decimal
    change_column :vitamins, :vitamin_b_6_mg, :decimal
    change_column :vitamins, :folate_dfe_μg, :decimal
    change_column :vitamins, :vitamin_b_12_μg, :decimal
    change_column :vitamins, :vitamin_a_rae_μg, :decimal
    change_column :vitamins, :vitamin_a_iu, :decimal
    change_column :vitamins, :vitamin_e_mg, :decimal
    change_column :vitamins, :vitamin_d_μg, :decimal
    change_column :vitamins, :vitamin_d_iu, :decimal
    change_column :vitamins, :vitamin_k_μg, :decimal
    change_column :lipids, :saturated_fatty_acids_g, :decimal
    change_column :lipids, :monounsaturated_fatty_acids_g, :decimal
    change_column :lipids, :polyunsaturated_fatty_acid_g, :decimal
    change_column :lipids, :trans_fatty_acid_g, :decimal
    change_column :lipids, :cholesterol_mg, :decimal
    change_column :others, :caffine_mg, :decimal

  end
end
