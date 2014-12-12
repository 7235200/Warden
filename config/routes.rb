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

  get 'data-filter' => 'transactions#data_filer_show'
  get 'category-filter' => 'transactions#category_filter_show'
  get 'money-filter' => 'transactions#money_filter_show'

  get 'chart' => 'charts#index'
  get 'three_month' => 'charts#three_month'
  get 'month' => 'charts#month'
  get 'today' => 'charts#today'

end
