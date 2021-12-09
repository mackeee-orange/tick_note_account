# frozen_string_literal: true
module Mutations
  # UpdateNote
  class UpdateNote < BaseMutation
    field :note, Types::NoteType, null: false

    argument :note_id, ID, required: true, loads: Types::NoteType
    argument :title, String, required: false
    argument :content, String, required: false

    def authorize?(note:)
      note.author == current_account
    end

    def resolve(note:, **args)
      note = note.update!(args)

      { note: note }
    end
  end
end
