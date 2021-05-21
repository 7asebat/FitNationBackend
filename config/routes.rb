Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :exercises
  resources :foods
  resources :recipes
  resources :nutrition_specifications
  resources :client_weight_nutritions

  scope :client_weight_nutritions do
    patch ":id/add_spec", to: "client_weight_nutritions#add_spec"
    delete ":id/remove_spec", to: "client_weight_nutritions#remove_spec"

  end
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

  match "*unmatched_route", :to => "errors#routing", via: [:get, :post, :delete, :put, :patch]
end
