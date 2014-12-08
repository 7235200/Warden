Rails.application.routes.draw do
  root             'static_pages#home'
  get 'signup'  => 'users#new'
  resources :users
  resources :kinds
  resources :transactions

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'recharge' => 'users#recharge'
  post 'recharge' => 'users#add_money'
end
