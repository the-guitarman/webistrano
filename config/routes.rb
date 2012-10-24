Webistrano::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  root :to => "projects#dashboard"

  get "home" => "projects#dashboard"
  get "stylesheets" => "stylesheets#application"

#  match ':controller/service.wsdl', :action => 'wsdl'

  resources :hosts
  resources :recipes do
    collection do
      get :preview
    end
  end
  resources :projects do
    member do
      get :dashboard
    end
    resources :project_users
    resources :project_configurations

    resources :stages do
      member do
        get :capfile
        match :recipes
        get :tasks
      end
      resources :stage_users
      
      resources :stage_users

      resources :stage_users
      resources :stage_configurations
      resources :roles
      resources :deployments do
        collection do
          get :latest
        end
        member do
          post :cancel
        end
      end
    end
  end

  # RESTful auth
  resources :users do
    member do
      get :deployments
      post :enable
    end
  end
  resources :sessions do
    collection do
      get :version
    end
  end
  get '/signup', :controller => 'users', :action => 'new'
  get  '/login', :controller => 'sessions', :action => 'new'
  delete '/logout', :controller => 'sessions', :action => 'destroy'

  # stylesheet
  #stylesheet '/stylesheets/application.css', :controller => 'stylesheets', :action => 'application'

  # Install the default route as the lowest priority.
  match ':controller/:action/:id.:format'
  match ':controller/:action/:id'
end
