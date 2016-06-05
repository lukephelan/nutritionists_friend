# Nutritionist's Friend

## Overview

This web application is for logging food intake and tracking nutrients. this
application also allows for logging and tracking bodyweight.

### Technology Used

#### Gems

As well as the default Gems used in Rails 4.2.6, the following Gems have been
used:

1. 'devise' - for handling user accounts and sessions
2. 'httparty' - to access external API's
3. 'pg' - for PostgreSQL
4. 'chartkick' - to access and utilise the Google Chart API
5. 'groupdate' - groups data in a date range for the 'chartkick' gem
5. 'bootstrap-sass' - to aid with the CSS

#### API's

The primary API used for this application comes from the United States
Department of Agriculture, and is their National Nutrient Database.

The Google Chart API is handled by the 'chartkick' gem.

### Database Creation

### Database Initialisation

### Challenges

1. Using Devise with an existing Resource



2. Adding more fields to the Devise User model



3. Retrieving both the food database number and the food name from one radio
selection



4. Saving to a second table when adding to a first table (fixed with callback)



5. Retrieving the nutrients from the API when the array indices change



6. Deleting intakes when there is a dependant entry in a second table



7. Selecting data for the charts

### Work for the Future

1. Custom food entries
2. Log-in for the admin (Nutritionist) to set goals for users
3. Selector on the Dashboard to view charts of interest only
4. Slider to change date range for historical data
5. Profile pictures for users
6. A personal blog for users to interact with their Nutritionist, who in turn,
can make comments to their blog
7. Pagination on the search results and the log table
8. Fix the daily chart for calories as it displays very small fractions
when nothing has been logged
