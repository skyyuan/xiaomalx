Xiaomalx::Application.routes.draw do
  devise_for :student_admins
  # devise_for :student_admins, :controllers => { :sessions => "student_admins/sessions" }
  root :to => 'home#index'

  resources :students do
    post :code, on: :collection
    get :census, on: :collection
  end

  resources :curriculums do
     get :add1, on: :member
     get :add2, on: :member
     get :quer_hour, on: :collection
     get :same_month, on: :collection
  end

  resources :individual_lessons do
      get :admins, on: :collection
      get :admins_delete, on: :collection
      get :admin_edit, on: :collection
      get :admin_update, on: :collection
      get :today_individual, on: :collection
      get :course, on: :collection
  end

  resources :messages

  resources :users do
    post :login, on: :collection
    post :register, on: :collection
    post :verify_phone, on: :collection
    post :forgot, on: :collection
  end

  resources :advisory_informations

  resources :categories do
    get :profe_children_tags, on: :collection
  end

  resources :questions do
    get :question_count, on: :collection
    get :questions_tags, on: :collection
    get :hot_tag, on: :collection
    get :question_answers, on: :collection
  end

  resources :answers

  match "/consultant_user_list" => "consultant_user#consultant_user_list",:via=>[:get]

  match ':controller(/:action(/:id))(.:format)',:via=>[:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
