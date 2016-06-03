class CreateBodyweights < ActiveRecord::Migration
  def change
    create_table :bodyweights do |t|
      t.references :user, index: true, foreign_key: true
      t.date :bodyweight_recorded_date
      t.integer :bodyweight_recorded_kg

      t.timestamps null: false
    end
  end
end
