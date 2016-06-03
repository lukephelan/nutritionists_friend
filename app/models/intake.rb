class Intake < ActiveRecord::Base
  belongs_to :user
  has_one :proximate, dependent: :destroy
  has_one :mineral, dependent: :destroy
  has_one :vitamin, dependent: :destroy
  has_one :lipid, dependent: :destroy
  has_one :other, dependent: :destroy
  after_create :fetch_nutrients

  validates :consumed_item, presence: true
  validates :consumed_qty, presence: true
  validates :logged_time, presence: true
  validates :logged_date, presence: true

  private
    def fetch_nutrients

      # Fetch the nutrients for this intake log - store them in the DB

      @api_response = HTTParty.get "http://api.nal.usda.gov/ndb/reports/?ndbno=#{self.ndbno}&type=b&format=json&api_key=8gYd9RFbST30DyUJm7pJ0Q2Rbjsv9fseOAKe2O6K"

      @proximate = Proximate.new
      @proximate.intake_id = self.id

      @water_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Water"}
      @proximate.water_g = (@api_response["report"]["food"]["nutrients"][@water_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @energy_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Energy"}
      @proximate.energy_kcal = (@api_response["report"]["food"]["nutrients"][@energy_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @protein_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Protein"}
      @proximate.protein_g = (@api_response["report"]["food"]["nutrients"][@protein_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @fat_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Total lipid (fat)"}
      @proximate.total_fat_g = (@api_response["report"]["food"]["nutrients"][@fat_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @carb_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Carbohydrate, by difference"}
      @proximate.carbohydrate_g = (@api_response["report"]["food"]["nutrients"][@carb_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @fibre_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Fiber, total dietary"}
      @proximate.total_dietary_fibre_g = (@api_response["report"]["food"]["nutrients"][@fibre_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @sugar_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Sugars, total"}
      @proximate.total_sugar_g = (@api_response["report"]["food"]["nutrients"][@sugar_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @proximate.save


      @mineral = Mineral.new
      @mineral.intake_id = self.id

      @calcium_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Calcium, Ca"}
      @mineral.calcium_mg = (@api_response["report"]["food"]["nutrients"][@calcium_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @iron_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Iron, Fe"}
      @mineral.iron_mg = (@api_response["report"]["food"]["nutrients"][@iron_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @magnesium_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Magnesium, Mg"}
      @mineral.magnesium_mg = (@api_response["report"]["food"]["nutrients"][@magnesium_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @phosphorus_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Phosphorus, P"}
      @mineral.phosphorus_mg = (@api_response["report"]["food"]["nutrients"][@phosphorus_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @potassium_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Potassium, K"}
      @mineral.potassium_mg = (@api_response["report"]["food"]["nutrients"][@potassium_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @sodium_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Sodium, Na"}
      @mineral.sodium_mg = (@api_response["report"]["food"]["nutrients"][@sodium_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @zinc_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Zinc, Zn"}
      @mineral.zinc_mg = (@api_response["report"]["food"]["nutrients"][@zinc_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @mineral.save


      @vitamin = Vitamin.new
      @vitamin.intake_id = self.id

      @vitamin_c_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin C, total ascorbic acid"}
      @vitamin.vitamin_c_mg = (@api_response["report"]["food"]["nutrients"][@vitamin_c_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @thiamin_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Thiamin"}
      @vitamin.thiamin_mg = (@api_response["report"]["food"]["nutrients"][@thiamin_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @riboflavin_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Riboflavin"}
      @vitamin.riboflavin_mg = (@api_response["report"]["food"]["nutrients"][@riboflavin_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @niacin_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Niacin"}
      @vitamin.niacin_mg = (@api_response["report"]["food"]["nutrients"][@niacin_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin_b6_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin B-6"}
      @vitamin.vitamin_b_6_mg = (@api_response["report"]["food"]["nutrients"][@vitamin_b6_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @folate_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Folate, DFE"}
      @vitamin.folate_dfe_μg = (@api_response["report"]["food"]["nutrients"][@folate_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin_b12_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin B-12"}
      @vitamin.vitamin_b_12_μg = (@api_response["report"]["food"]["nutrients"][@vitamin_b12_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin_a_rae_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin A, RAE"}
      @vitamin.vitamin_a_rae_μg = (@api_response["report"]["food"]["nutrients"][@vitamin_a_rae_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin_a_iu_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin A, IU"}
      @vitamin.vitamin_a_iu = (@api_response["report"]["food"]["nutrients"][@vitamin_a_iu_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin_e_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin E (alpha-tocopherol)"}
      @vitamin.vitamin_e_mg = (@api_response["report"]["food"]["nutrients"][@vitamin_e_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin_d_g_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin D (D2 + D3)"}
      @vitamin.vitamin_d_μg = (@api_response["report"]["food"]["nutrients"][@vitamin_d_g_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin_d_iu_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin D"}
      @vitamin.vitamin_d_iu = (@api_response["report"]["food"]["nutrients"][@vitamin_d_iu_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin_k_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Vitamin K (phylloquinone)"}
      @vitamin.vitamin_k_μg = (@api_response["report"]["food"]["nutrients"][@vitamin_k_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @vitamin.save


      @lipid = Lipid.new
      @lipid.intake_id = self.id

      @sat_fat_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Fatty acids, total saturated"}
      @lipid.saturated_fatty_acids_g = (@api_response["report"]["food"]["nutrients"][@sat_fat_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @mono_fat_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Fatty acids, total monounsaturated"}
      @lipid.monounsaturated_fatty_acids_g = (@api_response["report"]["food"]["nutrients"][@mono_fat_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @poly_fat_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Fatty acids, total polyunsaturated"}
      @lipid.polyunsaturated_fatty_acid_g = (@api_response["report"]["food"]["nutrients"][@poly_fat_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @trans_fat_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Fatty acids, total trans"}
      @lipid.trans_fatty_acid_g = (@api_response["report"]["food"]["nutrients"][@trans_fat_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @chol_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Cholesterol"}
      @lipid.cholesterol_mg = (@api_response["report"]["food"]["nutrients"][@chol_index]["value"].to_f)*(self.consumed_qty.to_f/100)

      @lipid.save

      @other = Other.new
      @other.intake_id = self.id

      @caffeine_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Caffeine"}
      @other.caffine_mg = (@api_response["report"]["food"]["nutrients"][@caffeine_index]["value"].to_f)*(self.consumed_qty.to_f/100)
      @other.save

    end

end
