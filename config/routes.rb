DoIndie::Application.routes.draw do
  # config/routes.rb

  root "pages#home"
  get '/:locale' => 'pages#home'
  
  localized do
  
    get "home", to: "pages#home", as: "home"
    get "inside", to: "pages#inside", as: "inside"
  
    resources :bands, :venues, :events
    resources :user_fans, only: [:create, :destroy]
    resources :event_bands, only: [:create, :destroy]
    resources :event_venues, only: [:create, :destroy]
    
    devise_for :users
  
    namespace :admin do
      root "base#index"
      resources :users, :bands, :venues, :events
    end
  end
end
