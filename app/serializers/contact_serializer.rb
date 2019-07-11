# frozen_string_literal: true

class ContactSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :cell_phone, :zip_code
end
