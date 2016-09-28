require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'day_subjects#index'

  resources :day_subjects
  post 'social' => 'social#create'

  namespace :account do
    get 'statistic' => 'statistic#index'
  end

end
