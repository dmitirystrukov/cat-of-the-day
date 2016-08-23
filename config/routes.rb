Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'day_subjects#index'

  resources :day_subjects

  match 'social' => 'social#create', via: :post
  match 'social' => 'social#post_statistic', via: :get
end
