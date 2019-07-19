# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  scope module: :api do
    scope module: :v1 do
      resources :contacts do
        resources :activities, only: %i[index create update destroy]
      end

      scope module: :auth do
        post :signup, to: 'registration#create'
      end
    end
  end
end
