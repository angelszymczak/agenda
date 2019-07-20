# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  scope module: :api do
    scope module: :v1, constraints: ApiVersion.new(:v1, true) do
      resources :contacts do
        resources :activities, only: %i[index create update destroy]
      end

      scope module: :auth do
        post :sign_up, to: 'registration#create'
        post :sign_in, to: 'authentication#create'
      end
    end
  end
end
