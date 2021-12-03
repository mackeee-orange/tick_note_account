module Resolvers
  class AccountsResolver < BaseResolver
    type [Types::AccountType], null: true

    def resolve
      Account.all
    end
  end
end