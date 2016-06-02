class Intake < ActiveRecord::Base
  belongs_to :user
  has_one :proximate, dependent: :destroy
  after_create :fetch_proximates

  validates :consumed_item, presence: true
  validates :consumed_uom, presence: true
  validates :consumed_qty, presence: true
  validates :logged_time, presence: true
  validates :logged_date, presence: true

  private
    def fetch_proximates
      # Fetch the proximates for this intake log - store them in the DB

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
    end



end
