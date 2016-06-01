class ProximatesController < ApplicationController

  def new
    @proximate = Proximate.new
    @foodndbno = params[:chosen_food].split('$')[1]
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

end
