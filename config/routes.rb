DoIndie::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # config/routes.rb

  scope "(:locale)", locale: /en/ do
  root "pages#home"
  end

  # get '/:locale' => 'pages#home' #this conflicts with other routes
  
  localized do

    get "inside", to: "pages#inside", as: "inside"
    get "/blog", to: "posts#index", as: "blog"
    get "/genres/:name", to: "genres#show", as: "genre"
    get "/cities/:en_name", to: "cities#show", as: "city"
    get "/events/past", to: "events#past", as: "past_events"
    get "contact", to: "messages#index", as: "contact"
    get "photo", to: "pages#photo", as: "photo"
    get "/venues/map", to: "venues#map", as: "venues_map"
    get "/blog/admin", to: "posts#admin", as: "blog_admin"
    post "email_signup", to: "pages#signup", as: "sign_up"

    resources :messages, only: [:index, :create]
    resources :bands, :venues, :events, :posts
    resources :user_fans, only: [:create, :destroy]
    resources :event_bands, only: [:create, :destroy]
    resources :event_venues, only: [:create, :destroy]
    resources :band_managers, only: [:create, :destroy]
    resources :venue_managers, only: [:create, :destroy]
    resources :event_managers, only: [:create, :destroy]
  
    
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

    namespace :admin do
      root "base#index"
      get "/events/data", to: "events#data", as: "events_data"
      resources :users, :bands, :venues, :events, :band_managers, :venue_managers,
       :event_managers, :cities, :genres, :slides
    end  
  end
end
