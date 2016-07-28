Rails.application.routes.draw do
  namespace :users do
    resource :profile, only: [:edit, :update], controller: :profile
    resources :day_subjects do
      resource :statistics, except: [:index]
    end    
  end
end
