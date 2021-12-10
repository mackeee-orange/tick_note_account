# frozen_string_literal: true
module Mutations
  # CreateVote
  class CreateVote < BaseMutation
    field :vote, Types::VoteType, null: false

    argument :account_id, ID, required: true, loads: Types::AccountType
    argument :value, Int, required: true

    def resolve(**args)
      vote = Vote.find_or_create_by!(args)

      { vote: vote }
    end
  end
end
