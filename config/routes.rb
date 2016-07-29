Rails.application.routes.draw do
  devise_for :users

  root 'day_themes#index'

  resources :day_themes
end
