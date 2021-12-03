# frozen_string_literal: true
module Types
  # QueryType
  class QueryType < Types::BaseObject
    # field :id...
    add_field GraphQL::Types::Relay::NodeField
  end
end
