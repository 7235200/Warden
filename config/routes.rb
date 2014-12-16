Rails.application.routes.draw do
  get 'purposes/index'

  root             'static_pages#home'

  get 'signup'  => 'users#new'

  resources :users
  resources :kinds
  resources :transactions
  resources :purposes

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  post   'login'   => 'sessions#create'

  get   'test_user'   => 'sessions#login_test_user'

  get 'recharge' => 'users#recharge'
  post 'recharge' => 'users#add_money'

  get 'purpose_recharge' => 'purposes#recharge'
  post 'purpose_recharge' => 'purposes#add_money'



  get 'data-filter' => 'transactions#data_filer_show'
  get 'category-filter' => 'transactions#category_filter_show'
  get 'money-filter' => 'transactions#money_filter_show'

  get 'chart' => 'charts#index'
  get 'three_month' => 'charts#three_month'
  get 'month' => 'charts#month'
  get 'today' => 'charts#today'

end
