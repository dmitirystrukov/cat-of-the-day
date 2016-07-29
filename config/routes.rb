Rails.application.routes.draw do
  devise_for :users

  root 'day_subjects#index'

  resources :day_subjects
end
