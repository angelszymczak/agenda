# frozen_string_literal: true

ActiveAdmin.register Activity do
  menu priority: 3

  permit_params :description
end
