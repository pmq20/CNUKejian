# -*- encoding : utf-8 -*-
CNUKejian::Application.routes.draw do
  devise_for :users

  #小心隐含在下面的数个action
  #resources :institutes
  #resources :teachers
	get "/teachers/:teacher_id/courses/:id" => 'courses#show'
  resources :courses
  resources :coursewares
  #小心隐含在上面的数个action
  post "coursewares/:courseware_id/replies" => 'coursewares#create_reply'
  
  get "team" => "metawelcome#team"
  get "contact" => "metawelcome#contact"
  get "faq" => "metawelcome#faq"
  get "traffic" => "metawelcome#traffic"
  
  get 'welcome/top'
  get 'welcome/menu'
  get 'welcome/xi'
  get 'welcome/main'
  get 'welcome/autocomplete_course_name'
  get 'welcome/download_go'
  post 'welcome/download_go' => 'welcome#download_go_post'
  get 'welcome/upload_go'
  post 'welcome/upload_go' => 'welcome#upload_go_post'
  get 'welcome/res_rank'
  get 'welcome/user_rank'
  get 'welcome/replies_rank'
  get 'welcome/selfdefined'
  get 'welcome/statistics'
  get 'welcome/search'
	get 'yonghu/:id' => 'welcome#show_yonghu'
  
  get "cpan/profile"
  put "cpan/profile" => 'cpan#profile_put'
  get "cpan/history"
  get "cpan/my_res"
  get "cpan/pages"
  #get "cpan/get_free_credit"
  get "cpan/change_avatar"
  post "cpan/change_avatar" => "cpan#change_avatar_post"

  post "purchase/:courseware_id" => "welcome#purchase_post"
  root :to => "welcome#home"
  
  get "photo/:id" => "admin#photo"
  get "admin/yonghus" => "admin#yonghus"
  get "admin/replies" => "admin#replies"
  delete "admin/replies/:id" => "admin#replies_delete"
  post "admin/toggle_courseware/:id"=>"admin#toggle_courseware_post"
  post "admin/toggle_course/:id"=>"admin#toggle_course_post"
end
