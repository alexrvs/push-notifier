Rails.application.routes.draw do
  apipie
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    api_version(:module => "V1", :path => {:value => "v1"}) do
      as :api_v1_user do
        post 'users/sign_up', to: 'users/registrations#create'
      end

      devise_for :users, skip: :registrations, controllers: {
          sessions: 'api/v1/users/sessions',
      }
      resources :notes
    end
  end

end
