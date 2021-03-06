Dismassales::Application.routes.draw do
  resources :orders


  resources :categories


  resources :items

  match 'store/' => 'storefront#index', :as => :storefront
  match 'store/item/:id' => 'itemdetail#index', :as => :itemdetail
  match 'store/item/itemimage/:id' => 'itemdetail#image', :as => :itemimage
  match 'item/saveimage' => 'items#add_image', :as => :saveitemimage
  match 'store/shoppingcart' => 'shopping_cart#index', :as => :shoppingcart
  match 'store/shoppingcart/addtocart' => 'shopping_cart#addtocart', :as => :addtocart
  match 'store/shoppingcart/updatecart' => 'shopping_cart#updatecart', :as => :updatecart
  match 'store/shoppingcart/removeitem/:id' => 'shopping_cart#removeitem', :as => :removeitem
  match 'searchorders/' => 'orders#index', :as => :order_search
  match 'orderdetail/:id' => 'orders#detail', :as => :order_detail
  match 'shiporder/:id' => 'orders#shiporder', :as => :shiporder

  get "paypal_express/checkout"
  get "paypal_express/review"
  get "paypal_express/purchase"

  root :to => 'storefront#index'



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
