Rails.application.routes.draw do

  resources :proximates
  resources :intakes
  get 'home/index'
  get 'registrations/sign_up_params'
  get 'registrations/account_update_params'

  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "home#index"


  get '/search' => 'intakes#search'

  post '/result' => 'intakes#result'
  get '/result' => 'intakes#result'

  post '/newform' => 'intakes#new'
  # post '/newform' => 'proximates#new'

end
