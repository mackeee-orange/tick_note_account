# frozen_string_literal: true
module Types
  # Tag
  class TagType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :name, String, null: false
    # field :notes, [Types::NoteType], null: false

    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false
  end
end
