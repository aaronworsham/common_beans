CommonBeans::Application.routes.draw do



  resources :trackers
  resources :indices
  resources :fund_tickers
  resources :messages
  resources :buys
  resources :sells
  resources :portfolios
  resources :holdings
  resources :events
  resources :pages
  resources :sessions
  resource  :trust, :controller => 'Trust'
  resources :profiles
  resources :stock_tickers do
    get :autocomplete_stock_ticker_name, :on => :collection
    get :autocomplete_stock_ticker_symbol, :on => :collection
  end
  resources :fund_tickers do
    get :autocomplete_fund_ticker_name, :on => :collection
    get :autocomplete_fund_ticker_symbol, :on => :collection
  end
  resources :etf_tickers do
    get :autocomplete_etf_ticker_name, :on => :collection
    get :autocomplete_etf_ticker_symbol, :on => :collection
  end
  resource :dashboard, :controller => 'dashboard'
  resource :social, :controller => 'Social'

  resources :stock_holdings
  resources :fund_holdings
  resources :etf_holdings
  resources :cd_holdings
  resources :bond_holdings
  resources :multi_holdings


  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/profiles/public/:screen_name" => "profiles#show", :as => :public_profile
  root :to => 'pages#index'

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
  # match ':controller(/:action(/:id(.:format)))'
end
