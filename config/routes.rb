Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "deliveries#index"

  # Routes for the Delivery resource:

  post("/mark_as_received/:path_id", { :controller => "deliveries", :action => "mark_as_received" })


  # CREATE
  post("/insert_delivery", { :controller => "deliveries", :action => "create" })
          
  # READ
  get("/deliveries", { :controller => "deliveries", :action => "index" })
  
  get("/deliveries/:path_id", { :controller => "deliveries", :action => "show" })
  
  # UPDATE
  
  post("/modify_delivery/:path_id", { :controller => "deliveries", :action => "update" })
  
  # DELETE
  get("/delete_delivery/:path_id", { :controller => "deliveries", :action => "destroy" })

  #------------------------------

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
end
