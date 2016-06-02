class HomeController < ApplicationController
  def index
    if current_user
      @intakes = Intake.all
      render :dashboard
    end
  end

end
