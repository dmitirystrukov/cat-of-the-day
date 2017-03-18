require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'day_subjects#index'

  resources :day_subjects

  # scope module: :guest, shallow_prefix: :guest do
  #   resources :day_subjects, only: :show, shallow: true
  # end
  #
  # scope module: :client, shallow_prefix: :client do
  # end
  #
  # scope module: :consumer, shallow_prefix: :consumer do
  #   resources :day_subjects, only: :show, shallow: true
  # end

  # resources :day_subjects
  resources :social_publications, only: :create

  namespace :account do
    get 'statistic' => 'statistic#index'
  end

end
