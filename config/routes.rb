Rails.application.routes.draw do
  root 'companies#index'
  resources :companies, only: [:index, :show]

  namespace :admins, as: :admin, path: :admin do
    root 'top#index'
    resources :crawlers, only: [:index, :create]
  end
end
