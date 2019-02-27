Rails.application.routes.draw do

  get root to: 'top#index'
  get "top/about" => "top#about"

  # accounts
  get 'accounts/:user_id' => 'accounts#edit'
  patch 'accounts/:user_id' => 'accounts#update'
  get 'accounts/:user_id/check' => 'accounts#check_delete'
  patch 'accounts/:user_id/delete' => 'accounts#delete'

  #book_mark
  post '/users/:user_id/works/:work_id/book_marks' => 'book_marks#create'
  delete '/users/:user_id/works/:work_id/book_marks' => 'book_marks#destroy'

  #faq
  get 'tags/:tag'=> 'faqs#index', as: :tag
  get 'faqs'          => 'faqs#index'
  get 'faqs/new'      => 'faqs#new'
  get 'faqs/:id'      => 'faqs#show'
  get 'faqs/:id/edit' => 'faqs#edit'
  post 'faqs'         => 'faqs#create'
  patch 'faqs/:id'    => 'faqs#update'
  delete 'faqs/:id'   => 'faqs#destroy'

  # moku
  get '/ajax/justnow' => 'mokus#justnow'
  post '/ajax/mokus/create' => 'mokus#ajax_create'
  patch '/mokus/:id/finish' => 'mokus#finish'

  get 'users/:user_id/mokus/:moku_id/check' => 'mokus#check_delete'
  patch 'users/:user_id/mokus/:moku_id/delete' => 'mokus#delete'


  #moku_type
  get 'users/:user_id/moku_type/:moku_type_id/check' => 'moku_type#check_delete'
  patch 'users/:user_id/moku_type/:moku_type_id/delete' => 'moku_type#delete'

  #mypage
  get 'mypage/:user_id/edit' => 'mypage#edit'
  get 'mypage/:user_id' => 'mypage#show'
  get 'mypage' => 'mypage#index'
  # ↑application_controllerのafter_sign_in_path_for(resource)メソッドでログイン後はここがデフォになってるからuser_idはなくても大丈夫
  patch 'mypage/:user_id' => 'mypage#update'

  #work
  get '/users/:user_id/mokus/:id/work/new' => 'work#new' #mokus→moku_idへ！
  post '/users/:user_id/mokus/:moku_id/work' => 'work#create'

  get 'users/:user_id/works/:work_id/check' => 'work#check_delete'
  patch 'users/:user_id/works/:work_id/delete' => 'work#delete'


  devise_for :users
  get 'users/:user_id/works/:work_id/public' => 'work#for_public'
  delete 'work/:id/images/:image_id' => 'work#delete_image'

  resources :users do
    resources :mokus, :moku_type, :work, :book_marks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmls
end
