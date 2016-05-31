class HomeController < ApplicationController
  def index
    if current_user
      render :dashboard
    end
  end
end
