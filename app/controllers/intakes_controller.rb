class IntakesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @intakes = Intake.where(user_id:current_user.id)
    .order("logged_date DESC")
    .paginate(page: params[:page], per_page: 20)

  end

  def show
    @intake = Intake.find(params[:id])
    @proximate = Proximate.find_by_intake_id(params[:id])
    @vitamin = Vitamin.find_by_intake_id(params[:id])
    @mineral = Mineral.find_by_intake_id(params[:id])
    @lipid = Lipid.find_by_intake_id(params[:id])
    @other = Other.find_by_intake_id(params[:id])
  end

  def new
    @intake = Intake.new

    # split the string chosen_food into an array with two elements
    # use the zeroeth element for the food name
    # use the oneth element for the database number

    @foodname = params[:chosen_food].split('$')[0]
    @foodndbno = params[:chosen_food].split('$')[1]
  end

  def edit
    @intake = Intake.find(params[:id])
    @foodname = @intake.consumed_item
    @foodndbno = @intake.ndbno
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
    @api_key = ENV['NF_API']
    @search_result = HTTParty.get "http://api.nal.usda.gov/ndb/search/?format=json&sort=r&offset=0&api_key=#{@api_key}&q=#{params[:q]}"
  end


  private
    def intake_params
      params.require(:intake).permit(:user_id, :consumed_item, :consumed_qty, :logged_time, :logged_date, :ndbno)
    end

end
