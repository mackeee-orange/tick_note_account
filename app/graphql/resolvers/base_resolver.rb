module Resolvers
  # BaseResolver
  class BaseResolver < GraphQL::Schema::Resolver
    include Helpers::ContextAccessHelper
  end
end
