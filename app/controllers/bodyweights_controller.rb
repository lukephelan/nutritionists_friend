class BodyweightsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @bodyweights = Bodyweight.where(user_id:current_user.id)
    .order("bodyweight_recorded_date DESC")
    .paginate(page: params[:page], per_page: 20)
  end

  def show
    @bodyweight = Bodyweight.find(params[:id])
  end

  def new
    @bodyweight = Bodyweight.new
  end

  def edit
    @bodyweight = Bodyweight.find(params[:id])
  end

  def create
    @bodyweight = Bodyweight.new(bodyweight_params)
    @bodyweight.user_id = current_user.id

    if @bodyweight.save
        redirect_to @bodyweight
      else
        render 'new'
      end
  end

  def update
    @bodyweight = Bodyweight.find(params[:id])

    if @bodyweight.update(bodyweight_params)
      redirect_to @bodyweight
    else
      render 'edit'
    end
  end

  def destroy
    @bodyweight = Bodyweight.find(params[:id])
    @bodyweight.destroy

    redirect_to bodyweights_path
  end

  private
    def bodyweight_params
      params.require(:bodyweight).permit(:bodyweight_recorded_date, :bodyweight_recorded_kg)
    end

end
