# frozen_string_literal: true
module Mutations
  # CreateNote
  class CreateNote < BaseMutation
    field :note, Types::NoteType, null: false

    argument :title, String, required: true
    argument :content, String, required: false

    def resolve(**args)
      note = Note.find_or_create_by!(args)

      { note: note }
    end
  end
end
