Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  post 'api/signUp_mentor', to: 'api#signUp_mentor'
  post 'api/signUp_mentee', to: 'api#signUp_mentee'
  post 'api/add_work', to: 'api#add_work'
  post 'api/add_education', to: 'api#add_education'
  post 'api/sign_in', to: 'api#sign_in'
  post 'api/follow', to: 'api#follow'
  post 'api/get_followers', to: 'api#get_followers'
  post 'api/get_followees', to: 'api#get_followees'
  post 'api/delete_follower', to: 'api#delete_follower'
  post 'api/set_available', to: 'api#set_available'
  post 'api/set_available_time', to: 'api#set_available_time'
  post 'api/get_available', to: 'api#get_available'
  post 'api/get_available_date', to: 'api#get_available_date'
  post 'api/set_profile', to: 'api#set_profile'
  post 'api/get_profile', to: 'api#get_profile'
  post 'api/add_fields', to: 'api#add_fields'
  post 'api/signUp_google', to: 'api#signUp_google'
  post 'api/add_work_mentor', to: 'api#add_work_mentor'
  post 'api/get_mentors' , to: 'api#get_mentors'
  post 'api/get_mentees' , to: 'api#get_mentees'
  post 'api/get_mentors_user' , to: 'api#get_mentors_user'
  post 'api/post' , to: 'api#post'
  post 'api/add_invitation' , to: 'api#add_invitation'
  post 'api/add_invitation_topic' , to: 'api#add_invitation_topic'
  post 'api/get_notifications' , to: 'api#get_notifications'
  post 'api/respond_invite' , to: 'api#respond_invite'
  post 'api/decline_invite' , to: 'api#decline_invite'
  post 'api/schedules', to: 'api#schedules'
  post 'api/is_follower' , to: 'api#is_follower'
  post 'api/unfollow' , to: 'api#unfollow'
  post 'api/get_objectives' , to: 'api#get_objectives'
  post 'api/post_objective' , to: 'api#post_objective'
  post 'api/post_comment', to: 'api#post_comment'
  post 'api/get_comments', to: 'api#get_comments'
  post 'api/notify_test', to: 'api#notify_test'
  post 'api/signUp_linkedin' , to: 'api#signUp_linkedin'
  post 'api/get_invites' , to: 'api#get_invites'

  root 'app#index'

  post 'signUp' , to: 'app#signUp'
  post 'signUpMentor' , to: 'app#signUpMentor'
  get 'mentors' , to: 'app#home'
  get 'logout' , to:'app#logout'
  post 'login' , to:'app#login'
  get 'profile' , to: 'app#profile', as: 'profile'
  get 'requests' , to: 'app#requests'
  get 'invites' , to: 'app#invites'
  get "/auth/google_oauth2/callback", to: "app#googleAuth"
  post 'updateProfile' , to: 'app#updateProfile'

  get 'schedule' , to: 'app#schedule', as: 'schedule'


  get 'users/confirm_email/:id', to: 'users#confirm_email', as: 'confirm_email'
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get 'auth/linkedin/callback', to: 'sessions#linkedInLogin'
  get 'auth/failure', to: 'sessions#auth_failure'
#   get 'pages/index'
#   get 'pages/schedule'
#   post 'users', to: 'users#basic_signup'
#   post 'sessions', to: 'sessions#basic_login'
#   get 'auth/:provider/callback', to: 'sessions#linkedInLogin'
#   get 'auth/google_oauth2/callback', to: 'sessions#google_login'



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
