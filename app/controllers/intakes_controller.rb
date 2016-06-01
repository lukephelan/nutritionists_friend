class IntakesController < ApplicationController

  def index
    @intakes = Intake.all
  end

  def show
    @intake = Intake.find(params[:id])
  end

  def new
    @intake = Intake.new
  end

  def edit
    @intake = Intake.find(params[:id])
  end

  def create
    @intake = Intake.new(intake_params)
    @intake.user_id = current_user.id
    if @intake.save
        redirect_to @intake
      else
        render 'new'
      end
  end

  def update
    @intake = Intake.find(params[:id])

    if @intake.update(intake_params)
      redirect_to @intake
    else
      render 'edit'
    end
  end

  def destroy
    @intake = Intake.find(params[:id])
    @intake.destroy

    redirect_to intakes_path
  end

  def search
  end

  def result
    @search_result = HTTParty.get "http://api.nal.usda.gov/ndb/search/?format=json&sort=r&offset=0&api_key=8gYd9RFbST30DyUJm7pJ0Q2Rbjsv9fseOAKe2O6K&q=#{params[:q]}"
  end

  private
    def intake_params
      params.require(:intake).permit(:user_id, :consumed_item, :consumed_uom, :consumed_qty, :logged_time, :logged_date)
    end

    # def require_permission
    #   if current_user != Intake.find(params[:id]).user
    #     redirect_to '/intakes'
    #   end
    # end

end
