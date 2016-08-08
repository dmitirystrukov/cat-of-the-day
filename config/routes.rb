Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'day_subjects#index'

  resources :day_subjects do
    resources :day_subject_images, only: [:create, :update, :destroy]
  end
end
