Rails.application.routes.draw do
  # get 'errors/not_found'

  devise_for :customers, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    sign_up: 'signup'
  }

  resources :uploads, only: [:index,:create,:new]
  resources :recipients, only: [:index]
  resources :nfces, only: [:show, :index,:destroy] do
    collection do
      get 'export_report'
    end
  end

  get '/nfces', to: redirect('/')

  get 'nfces/index'
  root to: "nfces#index"

  match "*path", to: "errors#not_found", via: :all
end
