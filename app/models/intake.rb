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

      @proximate = Proximate.new
      @api_response = HTTParty.get "http://api.nal.usda.gov/ndb/reports/?ndbno=#{self.ndbno}&type=b&format=json&api_key=8gYd9RFbST30DyUJm7pJ0Q2Rbjsv9fseOAKe2O6K"
      @proximate.intake_id = self.id
      @proximate.water_g = (@api_response["report"]["food"]["nutrients"][0]["value"].to_f)*(self.consumed_qty.to_f/100)
      @proximate.energy_kcal = (@api_response["report"]["food"]["nutrients"][1]["value"].to_f)*(self.consumed_qty.to_f/100)
      @proximate.protein_g = (@api_response["report"]["food"]["nutrients"][2]["value"].to_f)*(self.consumed_qty.to_f/100)
      @proximate.total_fat_g = (@api_response["report"]["food"]["nutrients"][3]["value"].to_f)*(self.consumed_qty.to_f/100)
      @proximate.carbohydrate_g = (@api_response["report"]["food"]["nutrients"][4]["value"].to_f)*(self.consumed_qty.to_f/100)
      @proximate.total_dietary_fibre_g = (@api_response["report"]["food"]["nutrients"][5]["value"].to_f)*(self.consumed_qty.to_f/100)
      @proximate.total_sugar_g = (@api_response["report"]["food"]["nutrients"][6]["value"].to_f)*(self.consumed_qty.to_f/100)
      @proximate.save

      @mineral = Mineral.new
      @mineral.intake_id = self.id
      @mineral.calcium_mg = (@api_response["report"]["food"]["nutrients"][7]["value"].to_f)*(self.consumed_qty.to_f/100)
      @mineral.iron_mg = (@api_response["report"]["food"]["nutrients"][8]["value"].to_f)*(self.consumed_qty.to_f/100)
      @mineral.magnesium_mg = (@api_response["report"]["food"]["nutrients"][9]["value"].to_f)*(self.consumed_qty.to_f/100)
      @mineral.phosphorus_mg = (@api_response["report"]["food"]["nutrients"][10]["value"].to_f)*(self.consumed_qty.to_f/100)
      @mineral.potassium_mg = (@api_response["report"]["food"]["nutrients"][11]["value"].to_f)*(self.consumed_qty.to_f/100)
      @mineral.sodium_mg = (@api_response["report"]["food"]["nutrients"][12]["value"].to_f)*(self.consumed_qty.to_f/100)
      @mineral.zinc_mg = (@api_response["report"]["food"]["nutrients"][13]["value"].to_f)*(self.consumed_qty.to_f/100)
      @mineral.save

      @vitamin = Vitamin.new
      @vitamin.intake_id = self.id
      @vitamin.vitamin_c_mg = (@api_response["report"]["food"]["nutrients"][14]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.thiamin_mg = (@api_response["report"]["food"]["nutrients"][15]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.riboflavin_mg = (@api_response["report"]["food"]["nutrients"][16]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.niacin_mg = (@api_response["report"]["food"]["nutrients"][17]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.vitamin_b_6_mg = (@api_response["report"]["food"]["nutrients"][18]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.folate_dfe_μg = (@api_response["report"]["food"]["nutrients"][19]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.vitamin_b_12_μg = (@api_response["report"]["food"]["nutrients"][20]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.vitamin_a_rae_μg = (@api_response["report"]["food"]["nutrients"][21]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.vitamin_a_iu = (@api_response["report"]["food"]["nutrients"][22]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.vitamin_e_mg = (@api_response["report"]["food"]["nutrients"][23]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.vitamin_d_μg = (@api_response["report"]["food"]["nutrients"][24]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.vitamin_d_iu = (@api_response["report"]["food"]["nutrients"][25]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.vitamin_k_μg = (@api_response["report"]["food"]["nutrients"][26]["value"].to_f)*(self.consumed_qty.to_f/100)
      @vitamin.save

      @lipid = Lipid.new
      @lipid.intake_id = self.id
      @lipid.saturated_fatty_acids_g = (@api_response["report"]["food"]["nutrients"][27]["value"].to_f)*(self.consumed_qty.to_f/100)
      @lipid.monounsaturated_fatty_acids_g = (@api_response["report"]["food"]["nutrients"][28]["value"].to_f)*(self.consumed_qty.to_f/100)
      @lipid.polyunsaturated_fatty_acid_g = (@api_response["report"]["food"]["nutrients"][29]["value"].to_f)*(self.consumed_qty.to_f/100)
      @lipid.trans_fatty_acid_g = (@api_response["report"]["food"]["nutrients"][30]["value"].to_f)*(self.consumed_qty.to_f/100)
      @lipid.cholesterol_mg = (@api_response["report"]["food"]["nutrients"][31]["value"].to_f)*(self.consumed_qty.to_f/100)
      @lipid.save

      @other = Other.new
      @other.intake_id = self.id
      @other.caffine_mg = (@api_response["report"]["food"]["nutrients"][32]["value"].to_f)*(self.consumed_qty.to_f/100)

    end

end
