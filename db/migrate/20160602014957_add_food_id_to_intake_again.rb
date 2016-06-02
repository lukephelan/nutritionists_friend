class AddFoodIdToIntakeAgain < ActiveRecord::Migration
  def change
    add_column :intakes, :ndbno, :string
  end
end
