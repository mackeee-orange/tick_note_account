# frozen_string_literal: true
module Types
  # MutationType
  class MutationType < Types::BaseObject
    field :sign_up_account, mutation: Mutations::SignUpAccount
    field :sign_in_account, mutation: Mutations::SignInAccount

    # Note
    field :create_note, mutation: Mutations::CreateNote
    field :update_note, mutation: Mutations::UpdateNote
    field :delete_note, mutation: Mutations::DeleteNote

    # Tag
    field :create_tag, mutation: Mutations::CreateTag
  end
end
