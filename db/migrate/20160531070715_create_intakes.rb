class CreateIntakes < ActiveRecord::Migration
  def change
    create_table :intakes do |t|
      t.references :user, index: true, foreign_key: true
      t.time :logged_time
      t.date :logged_date
      t.string :consumed_item
      t.string :consumed_uom
      t.integer :consumed_qty

      t.timestamps null: false
    end
  end
end
