CommonBeans::Application.routes.draw do


  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)


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


  resources :stories
  resource :backbone, :controller => 'backbone'
  
  
  %w(
    portfolio 
    stock_holding stock_event stock_buy stock_sell 
    fund_holding fund_event fund_buy fund_sell
    etf_holding etf_event etf_buy etf_sell
    multi_holding multi_statement multi_statement_allocation
  ).each do |x|
    match "/#{x.pluralize}/:id" => 'backbone#show', :via => :get, :defaults => { :model_name => x.classify }
    match "/#{x.pluralize}/:id" => 'backbone#destroy', :via => :delete, :defaults => { :model_name => x.classify }
    match "/#{x.pluralize}" => 'backbone#create', :via => :post, :defaults => { :model_name => x.classify }

  end

  match "/auth/:provider/callback" => "sessions#create"
  match "/oauth2callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/failure" => "sessions#failure"
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
