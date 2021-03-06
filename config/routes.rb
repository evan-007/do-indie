DoIndie::Application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root "pages#home"
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }

  get '/ko', to: "pages#home"
  
  localized do
  
    mount Ckeditor::Engine => '/ckeditor'
    get "inside", to: "pages#inside", as: "inside"
    get "/blog", to: "posts#index", as: "blog"
    get "/genres/:name", to: "genres#show", as: "genre"
    get "/genres", to: "genres#index", as: "genres"
    get "/cities/:en_name", to: "cities#show", as: "city"
    get "cities/:en_name/events", to: "cities#events", as: "city_event"
    get "/cities", to: "cities#index", as: "cities"
    get "/events/past", to: "events#past", as: "past_events"
    get '/events/calendar', to: 'events#calendar', as: "calendar"
    get "contact", to: "messages#index", as: "contact"
    get "photo-of-the-month", to: "pages#photo", as: "photo"
    get "photo-of-the-month-winners", to: "pages#winner", as: "winner"
    get "/pages/jplayer", to: "pages#jplayer", as: "jplayer"
    get "/venues/map", to: "venues#map", as: "venues_map"
    get "/blog/admin", to: "posts#admin", as: "blog_admin"
    get 'tag/:tag', to: 'posts#tags', as: "tags"
    post "email_signup", to: "pages#signup", as: "sign_up"

    resources :bands, :venues, :events, :posts, :categories
    resources :messages, only: [:index, :create]
    resources :user_fans, only: [:create, :destroy]
    resources :venue_fans, only: [:create, :destroy]
    resources :event_bands, only: [:create, :destroy]
    resources :event_venues, only: [:create, :destroy]
    resources :band_managers, only: [:create, :destroy]
    resources :venue_managers, only: [:create, :destroy]
    resources :event_managers, only: [:create, :destroy]
    resources :pages, only: [:edit, :update]
    resources :slides, except: [:show]
  
    
    devise_for :users, :controllers => { :registrations => "registrations" }, skip: [:omniauth_callbacks]

    namespace :admin do
      root "base#index"
      get "/events/data", to: "events#data", as: "events_data"
      resources :users, :bands, :venues, :events, :band_managers, :venue_managers,
      :event_managers, :cities, :genres, :slides, :ads
    end  
  end
end
