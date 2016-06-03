class HomeController < ApplicationController
  def index

    # check if the user is logged in
    # if so, render the dashboard view
    # otherwise, the index view will be displayed for them to log in
    if current_user

      # join the intakes and proximates tables using the intakes foreign key
      # then sum all the nutrients we want, where the date is equal to today
      # and only for the current user
      # this can then be added to the pie chart to show what nutrients
      # have been eaten today
      @protein_consumed = Proximate.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:protein_g)
      @carbs_consumed = Proximate.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:carbohydrate_g)
      @fat_consumed = Proximate.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:total_fat_g)


      # join the intakes and proximates tables using the intakes foreign key
      # and then select all the entries for the nutrient we want
      # and only for the current user
      # this can then be used to chart intake over time
      @protein_over_time = Proximate.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("protein_g")
      @carbs_over_time = Proximate.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("carbohydrate_g")
      @fat_over_time = Proximate.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("total_fat_g")

      render :dashboard
    end
  end

end
