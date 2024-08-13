Rails.application.routes.draw do
  devise_for :customers
  get 'home/index'

  # get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"

  # root "posts#index"
end
