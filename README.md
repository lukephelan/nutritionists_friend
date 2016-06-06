# NUTRITIONIST'S FRIEND

### Overview

This web application is for logging food and nutrient intake. This
application also allows for logging and tracking bodyweight.


### Technology Used

#### Gems

As well as the default gems used in Rails 4.2.6, the following gems have been
used:

1. 'devise' - for handling user accounts and sessions
2. 'httparty' - to access external API's
3. 'pg' - for PostgreSQL
4. 'chartkick' - to access and utilise the Google Chart API
5. 'groupdate' - groups data in a date range for the 'chartkick' gem
5. 'bootstrap-sass' - to aid with the CSS

#### API's

The primary API used for this application comes from the United States
Department of Agriculture (USDA), and is their National Nutrient Database.

The Google Chart API is handled by the 'chartkick' gem.


### Challenges

**1. Using Devise with an existing Resource**

⋅⋅⋅Prior to implementing Devise I had already created a Users with scaffold. So
⋅⋅⋅all the necessary views and routes had been created, as well as the User table.

⋅⋅⋅Adding Devise over the top of this duplicated many views and routes, causing a
⋅⋅⋅lot of routing errors when navigating the page. Additionally, Devise added the
⋅⋅⋅email and password columns to the table which I had already created.

⋅⋅⋅Being this early on I decided it was quicker to restart the Rails project and
⋅⋅⋅build the Users again with Devise.

**2. Retrieving two values with one radio selection**

⋅⋅⋅The USDA API is first utilised with a search. This displays a list of foods
⋅⋅⋅with a radio selection. The problem with this is that I can only retrieve one
⋅⋅⋅value from a radio selection, when I needed two: the name of the food, and its
⋅⋅⋅database number.

⋅⋅⋅To achieve this, I assigned the value I wanted as a combination of both
⋅⋅⋅results as string, separated by the character '$':

`<input type="radio" name="chosen_food" value="<%=@search_result["list"]["item"]
[i]["name"]%>$<%= @search_result["list"]["item"][i]["ndbno"] %>">`

⋅⋅⋅The string was then split at the '$' character which returns an array. The
⋅⋅⋅zeroeth element of the array is stored to the table for the food name, and the
⋅⋅⋅oneth element of the array is stored as the food database number in the Intakes
⋅⋅⋅Controller:

`  def new
    @intake = Intake.new
    @foodname = params[:chosen_food].split('$')[0]
    @foodndbno = params[:chosen_food].split('$')[1]
  end
`

**3. Adding records to multiple tables at the same time**

⋅⋅⋅The Intakes table and all of the nutrient tables are related with a one-to-one
⋅⋅⋅relationship. I needed to create records on each nutrient table when a new
⋅⋅⋅record is created on the Intakes table. To do this, I needed to use a Callback.

⋅⋅⋅Essentially, after a record is created, a function called "fetch_nutrients" is
⋅⋅⋅run that assigns all the values to the nutrient tables based on corresponding
⋅⋅⋅values from the Intakes table (as they are all affected by the quantity of food
⋅⋅⋅consumed).

⋅⋅⋅This is run on the Intakes Model and is called as follows:

`after_create :fetch_nutrients`

**4. Retrieving the nutrients from the API when the array indices change**

⋅⋅⋅After a search is completed and food is chosen, a second API call is made to
⋅⋅⋅retrieve nutrient values for a chosen food, using the database number saved from
⋅⋅⋅the first search.

⋅⋅⋅For this result, the nutrient values are stored as a hash in an array. I
⋅⋅⋅initially made the mistake of assuming that the index of each nutrient would
⋅⋅⋅be the same for every food. This is a good reason not to use magic numbers!
⋅⋅⋅For some foods, certain nutrients are simply not listed, which throws the entire
⋅⋅⋅index order out of whack.

⋅⋅⋅To solve this I used an IF statement to check if the nutrient name is listed on
⋅⋅⋅the array (otherwise it will return NULL and give an error when saving to the
⋅⋅⋅database), and retrieve the index value matching the nutrient name. Then,
⋅⋅⋅with this index we can return the value we want for storage in the database.

⋅⋅⋅For example:

`if @energy_index = @api_response["report"]["food"]["nutrients"].index {|h| h["name"] == "Energy"}
  @proximate.energy_kcal = (@api_response["report"]["food"]["nutrients"][@energy_index]["value"].to_f)*(self.consumed_qty.to_f/100)
end`

**5. Deleting intakes when there is a dependant entry in a second table**

⋅⋅⋅Now that I had a series of tables that were all dependent on the Intakes table,
⋅⋅⋅if I tried to delete an entry in the Intakes table I would receive an error
⋅⋅⋅because the foreign key in the nutrient table would have nothing to link to.

⋅⋅⋅To overcome this, I assigned a destroy dependence in the Intakes model:

`has_one :vitamin, dependent: :destroy`

**6. Selecting data for the charts**

⋅⋅⋅Displaying data on the Dashboard proved to be quite tricky. The documentation
⋅⋅⋅for the Chartkick gem was quite clear in regards to installation, however I
⋅⋅⋅found that the explanation of how to pass in data was quite limited. To make
⋅⋅⋅this extra difficult, I was trying to display data from two separate tables
⋅⋅⋅that are linked.

⋅⋅⋅To deal with this I had to figure out how to join tables and I had to think hard
⋅⋅⋅about what type of data I was giving to Chartkick (a single entry, a column or a
⋅⋅⋅row, etc.).

⋅⋅⋅As an example, to display Vitamin intake over time, I had to join the Vitamins
⋅⋅⋅table to the Intakes table. I passed in some 'where' conditions to select
⋅⋅⋅data that is only relevant to the user who is logged in, and then selected the
⋅⋅⋅column that I wanted:

`@vitamin_c_over_time = Vitamin.joins(:intake)
  .where(intakes: {user_id: current_user.id})
  .select("vitamin_c_mg")`

⋅⋅⋅This is then presented on the Dashboard page as follows:

`<%= line_chart [
  {name: "Vitamin C (mg)", data: @vitamin_c_over_time
    .group_by_day(:logged_date, range: 7.days.ago.midnight..Time.now,
    format: "%B %d, %Y").sum(:vitamin_c_mg), width: "50%"}
  ] %>`

⋅⋅⋅This snippet shows one vitamin in a hash within an array. In the actual
⋅⋅⋅Dashboard code each nutrient is included as another element in the array (too
⋅⋅⋅much code to show here).

⋅⋅⋅An example of code in the Home Controller for displaying a single day of data:

`@protein_consumed = Proximate.joins(:intake)
  .where(intakes: {user_id: current_user.id})
  .where(intakes: {logged_date: Date.today})
  .sum(:protein_g)`

⋅⋅⋅The code is the same for each nutrient in the Proximates table that you want to
⋅⋅⋅add to the pie chart. The code on the Dashboard is then:

`<%= pie_chart [
  ["Protein (g)", @protein_consumed],
  ["Fat (g)", @fat_consumed],
  ["Carbohydrates (g)", @carbs_consumed]
] %>`


### Work for the Future

1. Custom foods
2. Log-in for the admin (Nutritionist) to set goals for users and display
target intake values on the relevant charts
3. Selector on the Dashboard to view charts of interest only, or to at least
switch between charts so the user does not need to scroll down so far
4. Slider to change date range for historical data charts
5. More user information, such as height and profile pictures
6. A personal blog for users to interact with their Nutritionist, who in turn,
can make comments to their blog
7. Users can upload photos to their personal blog to show weight loss (or gain)
8. Pagination on the log tables
9. Fix the daily chart for calories as it displays very small fractions
when nothing has been logged
