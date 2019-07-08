Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get 'sessions/new'

  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/about', to: 'users#about'
  post '/about', to: 'users#update_about'
  patch '/about', to: 'users#update_about'
  
  get  '/help', to: 'static_pages#help'
 # get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/add', to: 'topics#new'
  post '/add', to: 'topics#create'
  

  resources :users do
    member do
      get :following, :followers
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :topics   
  resources :users
  resources :account_activations, only: [:edit]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
