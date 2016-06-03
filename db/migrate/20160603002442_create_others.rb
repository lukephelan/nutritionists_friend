class CreateOthers < ActiveRecord::Migration
  def change
    create_table :others do |t|
      t.references :intake, index: true, foreign_key: true
      t.integer :caffine_mg

      t.timestamps null: false
    end
  end
end
