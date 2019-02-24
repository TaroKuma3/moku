Rails.application.routes.draw do
  devise_for :users
  # get 'top/index'
  get root to: 'top#index'
  get 'top/about'

  get 'mypage' => 'mypage#index'
  get 'mypage/show'


  get 'mokus/index'
  get 'mokus/new'
  get 'mokus/show'
  get 'mokus/edit'
  get 'mokus/check_delete'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
