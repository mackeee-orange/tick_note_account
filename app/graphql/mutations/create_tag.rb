# frozen_string_literal: true
module Mutations
  # CreateTag
  class CreateTag < BaseMutation
    field :tag, Types::TagType, null: false

    argument :name, String, required: true

    def resolve(**args)
      tag = Tag.find_or_create_by!(args)

      { tag: tag }
    end
  end
end
