DoIndie::Application.routes.draw do
  # config/routes.rb

  root "pages#home"

  
  # get '/:locale' => 'pages#home' #this conflicts with other routes
  
  localized do
  
    get "inside", to: "pages#inside", as: "inside"
  
    resources :bands, :venues, :events
    resources :user_fans, only: [:create, :destroy]
    resources :event_bands, only: [:create, :destroy]
    resources :event_venues, only: [:create, :destroy]
    resources :band_managers, only: [:create, :destroy]
    resources :venue_managers, only: [:create, :destroy]
  
    
    devise_for :users

    namespace :admin do
      root "base#index"
      resources :users, :bands, :venues, :events, :band_managers, :venue_managers 
    end  
  end
end
