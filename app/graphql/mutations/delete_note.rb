# frozen_string_literal: true
module Mutations
  # DeleteNote
  class DeleteNote < BaseMutation
    field :note, Types::NoteType, null: false

    argument :note_id, ID, required: true, loads: Types::NoteType

    def authorize?(note:)
      note.author == current_account
    end

    def resolve(note:)
      note = note.destroy!

      { note: note }
    end
  end
end
