# frozen_string_literal: true

module Types
  # Note
  class NoteType < Types::BaseObject
    graphql_name 'Note'
    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :title, String, null: false
    field :content, String, null: true
    field :expired_at, DateTime, null: false
    field :is_public, Boolean, null: false
    field :is_forever, Boolean, null: false

    # field :author, AccountType, null: false
    # field :tags, [TagType], null: false
    # field :votes, [VoteType], null: false

    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false
  end
end
