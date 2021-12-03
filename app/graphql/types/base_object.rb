# frozen_string_literal: true
module Types
  # BaseObject
  class BaseObject < GraphQL::Schema::Object
    include Helpers::ContextAccessHelper

    field_class Types::BaseField
  end
end
