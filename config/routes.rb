Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'day_subjects#index'

  resources :day_subjects

  namespace :account do
    get 'statistic' => 'statistic#index'
  end

  post 'social' => 'social#create'
end
