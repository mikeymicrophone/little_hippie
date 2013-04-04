LittleHippie::Application.routes.draw do
  resources :friend_emails

  resources :wishlist_items

  resources :wishlists do
    member do
      get :detail
    end
  end

  resources :design_features do
    member do
      put :move_up
      put :move_down
    end
  end

  resources :feedbacks

  resources :image_position_templates do
    resources :product_images
    member do
      get :load
      put :move_up
      put :move_down
    end
  end

  resources :body_style_product_features do
    member do
      put :move_up
      put :move_down
    end
  end

  resources :category_product_features do
    member do
      put :move_up
      put :move_down
    end
  end

  resources :banners

  resources :category_images

  resources :shipping_addresses

  resources :credit_cards

  resources :charges

  resources :items

  resources :carts do
    resources :items
  end

  resources :referrals do
    member do
      put :move_up
      put :move_down
    end
  end

  resources :body_style_sizes do
    member do
      put :move_up
      put :move_down
    end
  end

  devise_for :customers, :controllers => {:registrations => 'registrations', :sessions => 'sessions'} do
    match "registrations/update_screen" => "registrations#update_screen", :as => :update_screen
  end
  
  resources :customers do
    resources :carts
    resources :items
    resources :feedbacks
    resources :shipping_addresses
    resources :credit_cards
    member do
      get :detail
      get :admin_show
    end
  end

  resources :mailing_list_registrations do
    member do
      get :physical
    end
    collection do
      post :import
    end
  end

  resources :product_images

  resources :body_style_categorizations do
    member do
      put :move_up
      put :move_down
    end
  end

  resources :bulletin_pairings do
    member do
      put :move_up
      put :move_down
    end
  end

  resources :bulletins

  resources :category_pairings do
    member do
      put :move_up
      put :move_down
    end
  end

  resources :categories do
    resources :category_product_features
    resources :body_style_categorizations
    resources :category_pairings
    member do
      get :detail
      get :admin
    end
  end

  resources :inventories do
    member do
      get 'detail'
    end
    collection do
      get 'browse'
    end
  end

  resources :product_colors do
    collection do
      post :choose
      get :search
    end
    member do
      post :update_inventory
    end
  end

  resources :products do
    resources :product_colors
    resources :product_images
    member do
      get :detail
      get :add_colors_for
      put :move_up
      put :move_down
      post :generate_image
    end
    collection do
      post :search
    end
  end

  resources :colors do
    resources :product_colors
    resources :products
    resources :body_styles
    resources :designs
    member do
      put :move_up
      put :move_down
    end
  end

  resources :sizes do
    resources :body_style_sizes
    resources :products
    resources :designs
    member do
      put :move_up
      put :move_down
    end
  end

  resources :body_styles do
    resources :products
    resources :designs
    resources :product_colors
    resources :colors
    resources :body_style_product_features
    member do
      put :move_up
      put :move_down
      get :detail
    end
    collection do
      get :browse
      post :choose
    end
  end

  resources :designs do
    resources :products
    resources :product_colors
    resources :body_styles
    resources :colors
    member do
      put :move_up
      put :move_down
      get :add_body_styles_for
      get :detail
    end
    collection do
      get :browse
    end
  end

  devise_for :product_managers do
    match '/pm_logout' => 'devise/sessions#destroy', :as => 'product_manager_logout'
    match '/pm_login' => 'devise/sessions#new', :as => 'product_manager_login'
    match '/business' => 'devise/sessions#new'
  end
  resources :product_managers

  resources :content_pages do
    member do
      get :display
      put :move_up
      put :move_down
    end
  end

  devise_for :business_managers do
    match '/bm_logout' => 'devise/sessions#destroy', :as => 'business_manager_logout'
    match '/bm_login' => 'devise/sessions#new', :as => 'business_manager_login'
  end
  
  root :to => 'inventories#browse'

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
end
