FoursquarePush::Application.routes.draw do
  root :to => "checkins#index"
  resources :venues
  resources :users
  resources :checkins

  match "/auth/:provider/callback" => "sessions#create"  
  match "/signout" => "sessions#destroy", :as => :signout  
end
