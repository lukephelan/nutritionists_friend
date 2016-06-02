class HomeController < ApplicationController
  def index

    # Sum the three columns we want, where the corresponding intake has a date of today, and the user id is the same as the current user

    if current_user

      @protein_consumed = Proximate.joins(:intake).where(intakes: {user_id: current_user}, intakes: {logged_date: Time.zone.now.beginning_of_day}).sum(:protein_g)
      # @protein_consumed = Proximate.where(intake: Time.now.day).sum(:protein_g)
      @carbs_consumed = Proximate.joins(:intake).where(intakes: {user_id: current_user}, intakes: {logged_date: Time.zone.now.beginning_of_day}).sum(:carbohydrate_g)
      @fat_consumed = Proximate.joins(:intake).where(intakes: {user_id: current_user}, intakes: {logged_date: Time.zone.now.beginning_of_day}).sum(:total_fat_g)

# Time.zone.now.beginning_of_day

      render :dashboard
    end
  end

end
