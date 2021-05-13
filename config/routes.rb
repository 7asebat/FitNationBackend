Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :authentication do
    post "clients/sign_up", to: "clients#sign_up"
    post "sign_in", to: "authentication#sign_in"
  end

  match "*unmatched_route", :to => "errors#routing", via: [:get, :post, :delete, :put, :patch]
end
