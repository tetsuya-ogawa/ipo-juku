Rails.application.routes.draw do
  root 'top#index'

  namespace :admins, as: :admin, path: :admin do
    root 'top#index'
    resources :crawlers, only: [:index, :create]
  end
end
