Rails.application.routes.draw do
  root 'top#index'

  namespace :admins, as: :admin, path: :admin do
    root 'top#index'
  end
end
