Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :authentication do
    scope :clients do
      post "sign_up", to: "clients#sign_up"
    end

    scope :trainers do
      post "sign_up", to: "trainers#sign_up"
    end

    get "current_user", to: "authentication#current_user"
    post "sign_in", to: "authentication#sign_in"
  end

  match "*unmatched_route", :to => "errors#routing", via: [:get, :post, :delete, :put, :patch]
end
