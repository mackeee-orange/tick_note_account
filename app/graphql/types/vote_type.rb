# frozen_string_literal: true
module Types
  # Vote
  class VoteType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :value, Int, null: false
    field :note, Types::NoteType, null: false
    field :account, Types::AccountType, null: false

    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false
  end
end
