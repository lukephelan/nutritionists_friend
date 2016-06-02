class ProximatesController < ApplicationController

  def new
    @proximate = Proximate.new
    @foodndbno = params[:chosen_food].split('$')[1]
  end

  def create
    @proximate = Proximate.new
    @api_response = HTTParty.get "http://api.nal.usda.gov/ndb/reports/?ndbno=#{@foodnbdno}&type=b&format=json&api_key=8gYd9RFbST30DyUJm7pJ0Q2Rbjsv9fseOAKe2O6K"


    @proximate.intake_id = ??
    @proximate.water_g = @api_response["report"]["food"]["nutrients"][0]["value"]
    @proximate.energy_kcal = @api_response["report"]["food"]["nutrients"][1]["value"]
    @proximate.protein_g = @api_response["report"]["food"]["nutrients"][2]["value"]
    @proximate.total_fat_g = @api_response["report"]["food"]["nutrients"][3]["value"]
    @proximate.carbohydrate_g = @api_response["report"]["food"]["nutrients"][4]["value"]
    @proximate.total_dietary_fibre_g = @api_response["report"]["food"]["nutrients"][5]["value"]
    @proximate.total_sugar_g = @api_response["report"]["food"]["nutrients"][6]["value"]
    @proximate.save
  end

  private
    def proximate_params
      params.require(:proximate.permit(:intake_id, :water_g, :energy_kcal, :protein_g, :total_fat_g, :carbohydrate_g, :total_dietary_fibre_g, :total_sugar_g)
    end

end
