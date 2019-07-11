# frozen_string_literal: true

class ActivitySerializer < ActiveModel::Serializer
  attributes :description

  has_one :contact
end
