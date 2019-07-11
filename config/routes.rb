# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :api do
    scope module: :v1 do
      resources :contacts
    end
  end
end
