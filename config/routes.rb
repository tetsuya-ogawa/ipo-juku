Rails.application.routes.draw do
  root 'companies#index'
  resources :companies, only: [:index, :show]
  resources :articles, only: [:index, :show]

  namespace :admins, as: :admin, path: :admin do
    root 'top#index'
    resources :crawlers, only: [:index, :create]
    resources :articles
  end

  namespace :api, { format: :json } do
    namespace :v1 do
      resources :images, only: [:create]
    end
  end
end
