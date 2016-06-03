class RemoveMineralsTable < ActiveRecord::Migration
  def change
    drop_table :minerals
  end
end
