# frozen_string_literal: true
module Types
  # QueryType
  class QueryType < Types::BaseObject
    # field :id...
    add_field GraphQL::Types::Relay::NodeField

    field :current_account, Types::AccountType, null: true do
      current_account
    end

    field :accounts, resolver: Resolvers::AccountsResolver


  end
end
