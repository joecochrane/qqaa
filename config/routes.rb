Qqaa::Application.routes.draw do

  resources :answers

  resources :questions

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  get "pages/index"
  get "pages/about"
  get "pages/contact"
  
  get "users/:id" => "users#show"


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  
	match '/contact', :to => 'pages#contact'
	match '/about',   :to => 'pages#about'

	match '/editquestion' , :to => 'questions#adminlist'
	match '/signup',  :to => 'users#new'
	match '/signin',  :to => 'sessions#new'
	match '/signout', :to => 'sessions#destroy'
	match '/upvote_user/:id', :to => 'users#upvote_user'
	match '/downvote_user/:id', :to => 'users#downvote_user'
	match '/upvote_question/:id', :to => 'questions#upvote_question'
	match '/downvote_question/:id', :to => 'questions#downvote_question'
	match '/upvote_answer/:id', :to => 'questions#upvote_answer'
	match '/downvote_answer/:id', :to => 'questions#downvote_answer'
	match '/newcomment', :to => 'comments#newcomment'
	

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'questions#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
