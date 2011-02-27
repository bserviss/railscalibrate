Calibration::Application.routes.draw do

  resources :dependents

  resources :calibrators

  resources :events

  resources :issues

  resources :external_docs

  resources :items do
    resources :events, :issues, :dependents, :external_docs
  end

  match "item/:action", :controller => 'items', :action => /[a-z_]+/i
  #match "event/:action/:item_id", :controller => 'events', :action => /[a-z_]+/i
  
  match 'print_due_cal' => "items#printable_due_cal", :as => "print_due_cal"
  match 'in_cal' => "items#show_in_cal", :as => "in_cal"
  match "print_in_cal" => "items#printable_in_cal", :as => "print_in_cal"
  match 'inactive' => "items#show_inactive", :as => "inactive"
  match 'show_due_in_thirty_days' => "items#show_thirty_days", :as => "due_in_thirty"
  match 'print_thirty_day_report' => "items#printable_thirty_days", :as => "print_thirty"
  match 'show_due_in_sixty_days' => "items#show_sixty_days", :as => "due_in_sixty"
  match 'show_all_records' => "items#show_all_items", :as => "all_items"
  match 'show_all_issues' => "items#issue_remote", :as => "all_issues"
  match 'show_all_events' => "items#show_all_events", :as => "all_events"
  match 'show_all_dependents' => "items#dependent_remote", :as => "all_dependents"
  match 'show_all_documents' => "items#show_all_documents", :as => "all_documents"
  match 'search' => "items#search_remote", :as => "search"
  match 'return_from_cal/:item_id' => "events#return_from_cal", :as => "return_from_cal", :via => "get"
  
  root :to => "items#index"
  
  # The priority is based upon order of creation: first created -> highest priority.
  #connect 'return_cal/:id', :controller => 'events', :action=> 'return_from_cal'
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  match ':controller(/:action(/:id(.:format)))'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
