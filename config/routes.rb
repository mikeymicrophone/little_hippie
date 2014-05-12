require 'resque/server'
LittleHippie::Application.routes.draw do
  match '/reports/sales' => 'reports#sales_dates', :as => 'sales_report_dates', :via => :get
  match '/reports/sales' => 'reports#sales_report', :as => 'sales_report', :via => :post
  
  resources :banner_tags


  resources :sale_inclusions do
    collection do
      get :list
      get :check_products
      get :check_product_colors
    end
  end


  resources :sales do
    collection do
      get :browse
    end
  end


  mount Resque::Server.new, :at => "/pending_emails"
  
  resources :backgrounds


  resources :coupon_designs


  resources :coupon_products do
    collection do
      get :select
      get :select_category
      get :select_body_style
    end
  end


  resources :coupon_categories


  resources :meta_descriptions


  resources :coupons do
    collection do
      get :apply_to_price
    end
    resources :charges
  end


  resources :likes


  resources :invitations do
    member do
      put :approve
      get :email_approve
      get :redeem
      post :exchange
    end
  end

  resources :inventory_snapshots do
    collection do
      get :csv_of
      get :compare_dates
      post :differential
    end
    member do
      get :previous
    end
  end


  resources :stashed_inventories


  resources :suppliers


  resources :received_inventories


  resources :deliveries do
    member do
      put :receive
    end
  end


  resources :delivery_addresses


  resources :print_purchase_orders


  resources :billing_addresses


  resources :quantities do
    resources :deliveries
    member do
      get :print_on
    end
  end


  resources :garment_purchase_orders do
    resources :quantities
  end


  resources :unit_prices


  resources :garments do
    resources :banner_tags
  end


  resources :stocks


  resources :comments


  match '/facebook_session' => 'facebook#new_session', :as => 'new_session_facebook'

  resources :contacts do
    collection do
      get :make
      delete :delete
    end
  end

  resources :friend_emails

  resources :wishlist_items

  resources :wishlists do
    resources :wishlist_items
    member do
      get :detail
      post :sample_order
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

  resources :banners do
    resources :banner_tags
    collection do
      get :gallery
      get :customers_index
    end
    member do
      get :display
      put :move_up_in_gallery
      put :move_down_in_gallery
    end
  end

  resources :category_images

  resources :shipping_addresses

  resources :credit_cards

  resources :charges do
    member do
      get :edit_status_of
    end
    collection do
      post :search
    end
  end

  resources :items do
    member do
      get :check_inventory
    end
  end

  resources :carts do
    resources :items
    member do
      put :update_note
      put :update_shipping_method
      get :calculate_tax
      get :remove_tax
    end
  end

  resources :referrals do
    resources :carts
    member do
      put :move_up
      put :move_down
    end
  end

  resources :body_style_sizes do
    resources :unit_prices
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

  resources :bulletins do
    collection do
      get :browse
      get :retrieve_facebook_posts
    end
    member do
      get :detail
    end
  end

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
    resources :banner_tags
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
    resources :banner_tags
    member do
      get :detail
      get :add_colors_for
      put :move_up
      put :move_down
      post :generate_image
      get :pick_landing_color
      put :choose_landing_color
      get :check_inventory
    end
    collection do
      post :search
      match :customer_search
      match "/find/:query" => :customer_search
    end
  end

  resources :colors do
    resources :product_colors
    resources :products
    resources :body_styles
    resources :designs
    resources :banner_tags
    member do
      put :move_up
      put :move_down
      get :detail
    end
    collection do
      get :browse
    end
  end

  resources :sizes do
    resources :body_style_sizes
    resources :products
    resources :designs
    resources :banner_tags
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
    resources :banner_tags
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
    resources :banner_tags
    member do
      put :move_up
      put :move_down
      get :add_body_styles_for
      get :detail
      get :line_sheet
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
  
  match 'countries/:country_id/states' => 'states#index'
  
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
