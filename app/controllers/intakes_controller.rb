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
