Rails.application.routes.draw do

  get("/", { :controller => "application", :action => "index" })

  # Routes for the Na ingredient resource:

  # CREATE
  post("/insert_na_ingredient", { :controller => "na_ingredients", :action => "create" })
          
  # READ
  get("/na_ingredients", { :controller => "na_ingredients", :action => "index" })
  
  get("/na_ingredients/:path_id", { :controller => "na_ingredients", :action => "show" })
  
  # UPDATE
  
  post("/modify_na_ingredient/:path_id", { :controller => "na_ingredients", :action => "update" })
  
  # DELETE
  get("/delete_na_ingredient/:path_id", { :controller => "na_ingredients", :action => "destroy" })

  #------------------------------

  # Routes for the Alcohol resource:

  # CREATE
  post("/insert_alcohol", { :controller => "alcohols", :action => "create" })
          
  # READ
  get("/alcohols", { :controller => "alcohols", :action => "index" })
  
  get("/alcohols/:path_id", { :controller => "alcohols", :action => "show" })
  
  # UPDATE
  
  post("/modify_alcohol/:path_id", { :controller => "alcohols", :action => "update" })
  
  # DELETE
  get("/delete_alcohol/:path_id", { :controller => "alcohols", :action => "destroy" })

  #------------------------------

  # Routes for the Ingredient resource:

  # CREATE
  post("/insert_ingredient", { :controller => "ingredients", :action => "create" })
          
  # READ
  get("/ingredients", { :controller => "ingredients", :action => "index" })
  
  get("/ingredients/:path_id", { :controller => "ingredients", :action => "show" })
  
  # UPDATE
  
  post("/modify_ingredient/:path_id", { :controller => "ingredients", :action => "update" })
  
  # DELETE
  get("/delete_ingredient/:path_id", { :controller => "ingredients", :action => "destroy" })

  #------------------------------

  # Routes for the Bottle resource:

  # CREATE
  post("/insert_bottle", { :controller => "bottles", :action => "create" })
          
  # READ
  get("/bottles", { :controller => "bottles", :action => "index" })
  
  get("/bottles/:path_id", { :controller => "bottles", :action => "show" })
  
  # UPDATE
  
  post("/modify_bottle/:path_id", { :controller => "bottles", :action => "update" })
  
  # DELETE
  get("/delete_bottle/:path_id", { :controller => "bottles", :action => "destroy" })

  #------------------------------

  # Routes for the Saved recipe resource:

  # CREATE
  post("/insert_saved_recipe", { :controller => "saved_recipes", :action => "create" })
          
  # READ
  get("/saved_recipes", { :controller => "saved_recipes", :action => "index" })
  
  get("/saved_recipes/:path_id", { :controller => "saved_recipes", :action => "show" })
  
  # UPDATE
  
  post("/modify_saved_recipe/:path_id", { :controller => "saved_recipes", :action => "update" })
  
  # DELETE
  get("/delete_saved_recipe/:path_id", { :controller => "saved_recipes", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe resource:

  # CREATE
  post("/insert_recipe", { :controller => "recipes", :action => "create" })
         
  # READ
  get("/recipes", { :controller => "recipes", :action => "index" })
  
  get("/recipes/:path_id", { :controller => "recipes", :action => "show" })

  get("/random", { :controller => "recipes", :action => "random" })
  
  # UPDATE

  get("/modify_recipe_form/:path_id", { :controller => "recipes", :action => "update_form" })
  
  post("/modify_recipe/:path_id", { :controller => "recipes", :action => "update" })
  
  # DELETE
  get("/delete_recipe/:path_id", { :controller => "recipes", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
