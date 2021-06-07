Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :exercises do
    get "muscle_group", to:"exercises#getExerciseByMuscleGroup"
  end
  resources :exercises
  resources :foods
  resources :recipes
  resources :nutrition_specifications

  scope :client_weight_nutritions do
    patch ":id/add_spec", to: "client_weight_nutritions#add_spec"
    delete ":id/remove_spec/:nspec_id", to: "client_weight_nutritions#remove_spec"
    get "/client", to: "client_weight_nutritions#getAllClientWeightNutrition"
  end
  resources :client_weight_nutritions

  scope :recipes do
    patch ":id/add_food", to: "recipes#add_food"
    delete ":id/remove_food", to: "recipes#remove_food"
    get "nutritionist/:nutritionist_id", to: "recipes#get_recipes_nutritionist"
  end

  

  scope :authentication do
    scope :clients do
      post "sign_up", to: "clients#sign_up"
    end

    scope :trainers do
      post "sign_up", to: "trainers#sign_up"
    end

    scope :nutritionists do
      post "sign_up", to: "nutritionists#sign_up"
    end

    get "current_user", to: "authentication#current_user"
    post "sign_in", to: "authentication#sign_in"
  end

 
  scope :me do
    scope :workout_plans do
      get "/", to: "workout_plans#me_index"
      patch "active_plan", to:"clients#setActiveWorkoutPlan"
    end

    scope :exercises_instances do
      get "/", to: "clients_exercise_instance#me_index"
    end
  end

  scope :workout_plans do
    post "/", to: "workout_plans#create"
    get "/", to: "workout_plans#index"
    get "/:id", to: "workout_plans#get"
  end

  scope :admin do
    scope :users do
      get "/", to: "user_auth#index"
    end
  end

  scope :clients do
    delete "/:id", to: "clients#delete"

    scope :exercises_instances do
      post "/", to: "clients_exercise_instance#create"
    end
  end

  scope :trainers do
    delete "/:id", to: "trainers#delete"
  end

  scope :nutritionists do
    delete "/:id", to: "nutritionists#delete"
  end

  scope :admins do
    get "/dashboard", to: "admins#dashboard"
  end

  match "*unmatched_route", :to => "errors#routing", via: [:get, :post, :delete, :put, :patch], constraints: lambda{ |req|
    req.path.exclude? 'rails/active_storage'
  }
end
