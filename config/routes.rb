Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'day_subjects#index'

  resources :day_subjects
  match 'social_send' => 'social_send#create', via: :post
end
