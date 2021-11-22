# frozen_string_literal: true
# AppSchema
class AppSchema < GraphQL::Schema
  include ::GraphqlExceptionHandler

  mutation(Types::MutationType)
  query(Types::QueryType)

  class << self
    def resolve_type(_type, obj, _ctx = {})
      Types.const_get("#{obj.class}Type")
    end

    def object_from_id(node_id, _ctx = {})
      type_name, object_id = self::UniqueWithinType.decode(node_id, separator: ':')
      Object.const_get(type_name).find(object_id)
    end

    def id_from_object(object, _type = nil, _ctx = {})
      self::UniqueWithinType.encode(object.class.name, object.id, separator: ':')
    end

    # なくてもnilを返すが明示
    def unauthorized_object(_e)
      nil
    end

    def unauthorized_field(_error)
      nil
    end

    def type_error(e, ctx)
      Sentry.set_context('graphql', { query: ctx.query.query_string })
      Sentry.capture_exception(e)
      super
    end
  end
end
