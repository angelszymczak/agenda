# frozen_string_literal: true

ActiveAdmin.register Contact do
  menu priority: 2

  permit_params :first_name, :last_name, :cell_phone, :zip_code
end
