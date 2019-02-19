Rails.application.routes.draw do
  get root to: 'mypage#index'
  # get 'mypage/index'
  get 'mypage/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
