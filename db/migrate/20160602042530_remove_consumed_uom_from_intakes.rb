class RemoveConsumedUomFromIntakes < ActiveRecord::Migration
  def change
    remove_column :intakes, :consumed_uom, :string
  end
end
