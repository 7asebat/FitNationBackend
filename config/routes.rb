Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :exercises
  resources :foods
  match '*unmatched_route', :to => 'errors#routing', via: [:get, :post, :delete, :put, :patch]
end
