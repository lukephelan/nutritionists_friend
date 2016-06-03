class CreateLipids < ActiveRecord::Migration
  def change
    create_table :lipids do |t|
      t.references :intake, index: true, foreign_key: true
      t.integer :saturated_fatty_acids_g
      t.integer :monounsaturated_fatty_acids_g
      t.integer :polyunsaturated_fatty_acid_g
      t.integer :trans_fatty_acid_g
      t.integer :cholesterol_mg

      t.timestamps null: false
    end
  end
end
