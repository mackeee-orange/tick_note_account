# frozen_string_literal: true

module Resolvers
  class CurrentAccountResolver < BaseResolver
    type Types::AccountType, null: false

    def resolve
      current_account
    end
  end
end
