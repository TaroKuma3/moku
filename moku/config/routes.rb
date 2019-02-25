Rails.application.routes.draw do
  devise_for :users

  #top
  get root to: 'top#index'
  get 'top/about'

  #mypage
  get 'mypage' => 'mypage#index'
  get 'mypage/show'

  # moku
  get 'mokus/index'
  get 'mokus/new'
  get 'mokus/show'
  get 'mokus/edit'
  get 'mokus/check_delete'
  get '/ajax/justnow' => 'mokus#justnow'
  post '/ajax/mokus/create' => 'mokus#ajax_create'
  patch '/mokus/:id/finish' => 'mokus#finish'
  get 'users/:user_id/mokus/:moku_id/check' => 'mokus#check_delete'
  patch 'users/:user_id/mokus/:moku_id/delete' => 'mokus#delete'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
