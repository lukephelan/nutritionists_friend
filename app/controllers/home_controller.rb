class HomeController < ApplicationController
  def index

    # check if the user is logged in
    # if so, render the dashboard view
    # otherwise, the index view will be displayed for them to log in
    if current_user

      @bodyweight_over_time = Bodyweight.where(user_id: current_user.id)
      .where("bodyweight_recorded_kg > ?", 0)
      .select("bodyweight_recorded_kg")


      # join the intakes and proximates tables using the intakes foreign key
      # then sum all the nutrients we want, where the date is equal to today
      # and only for the current user
      # this can then be added to the pie/bar chart to show what nutrients
      # have been eaten today
      @calories_consumed = Proximate.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:energy_kcal)
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


      # join the intakes and vitamins tables using the intakes foreign key
      # then sum all the nutrients we want, where the date is equal to today
      # and only for the current user
      # this can then be added to the bar chart to show what nutrients
      # have been eaten today
      @vitamin_c_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:vitamin_c_mg)
      @thiamin_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:thiamin_mg)
      @riboflavin_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:riboflavin_mg)
      @niacin_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:niacin_mg)
      @vitamin_b6_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:vitamin_b_6_mg)
      @folate_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:folate_dfe_μg)
      @vitamin_b12_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:vitamin_b_12_μg)
      @vitamin_a_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:vitamin_a_rae_μg)
      @vitamin_e_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:vitamin_e_mg)
      @vitamin_d_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:vitamin_d_μg)
      @vitamin_k_consumed = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:vitamin_k_μg)


      # join the intakes and minerals tables using the intakes foreign key
      # then sum all the nutrients we want, where the date is equal to today
      # and only for the current user
      # this can then be added to the bar chart to show what nutrients
      # have been eaten today
      @calcium_consumed = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:calcium_mg)
      @iron_consumed = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:iron_mg)
      @magnesium_consumed = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:magnesium_mg)
      @phosphorus_consumed = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:phosphorus_mg)
      @potassium_consumed = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:potassium_mg)
      @sodium_consumed = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:sodium_mg)
      @zinc_consumed = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:zinc_mg)


      # join the intakes and lipids tables using the intakes foreign key
      # then sum all the nutrients we want, where the date is equal to today
      # and only for the current user
      # this can then be added to the bar chart to show what nutrients
      # have been eaten today
      @saturated_fat_consumed = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:saturated_fatty_acids_g)
      @mono_fat_consumed = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:monounsaturated_fatty_acids_g)
      @poly_fat_consumed = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:polyunsaturated_fatty_acid_g)
      @trans_fat_consumed = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:trans_fatty_acid_g)
      @cholesterol_consumed = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .where(intakes: {logged_date: Date.today})
        .sum(:cholesterol_mg)



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


      @vitamin_c_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("vitamin_c_mg")
      @thiamin_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("thiamin_mg")
      @riboflavin_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("riboflavin_mg")
      @niacin_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("niacin_mg")
      @vitamin_b6_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("vitamin_b_6_mg")
      @folate_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("folate_dfe_μg")
      @vitamin_b12_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("vitamin_b_12_μg")
      @vitamin_a_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("vitamin_a_rae_μg")
      @vitamin_e_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("vitamin_e_mg")
      @vitamin_d_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("vitamin_d_μg")
      @vitamin_k_over_time = Vitamin.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("vitamin_k_μg")

      @calcium_over_time = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("calcium_mg")
      @iron_over_time = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("iron_mg")
      @magnesium_over_time = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("magnesium_mg")
      @phosphorus_over_time = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("phosphorus_mg")
      @potassium_over_time = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("potassium_mg")
      @sodium_over_time = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("sodium_mg")
      @zinc_over_time = Mineral.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("zinc_mg")

      @sat_fat_over_time = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("saturated_fatty_acids_g")
      @mono_fat_over_time = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("monounsaturated_fatty_acids_g")
      @poly_fat_over_time = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("polyunsaturated_fatty_acid_g")
      @trans_fat_over_time = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("trans_fatty_acid_g")
      @chol_over_time = Lipid.joins(:intake)
        .where(intakes: {user_id: current_user.id})
        .select("cholesterol_mg")

      render :dashboard
    end
  end

end
