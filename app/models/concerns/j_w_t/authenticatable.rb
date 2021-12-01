# frozen_string_literal: true
module JWT
  # JWT用Concern
  module Authenticatable
    extend ActiveSupport::Concern

    ALGORITHM = 'HS256'

    included do
      # JWT失効させる
      def invalidate_jwt!(token)
        payload, _header = JWT::Helper.decode(token)
        _type, sub = GraphQL::Schema::UniqueWithinType.decode(payload['sub'], separator: ':')
        fail Exceptions::UnauthorizedError if sub != id

        Jti.destroy!(payload['jti'])
      end

      def jwt
        iat = Time.now.to_i
        exp = iat + 7 * 24 * 3600 # 有効期限は1週間 FIXME: 環境変数とかで設定できる方が良いかも
        jti = Jti.create!

        payload = {
          iat: iat,
          exp: exp,
          jti: jti.id,
          sub: GraphQL::Schema::UniqueWithinType.encode(self.class.name, id, separator: ':')
        }

        JWT::Helper.encode(payload, ALGORITHM, 'JWT')
      end
    end

    class_methods do
      def authenticate!(token)
        payload, _header = JWT::Helper.decode(
          token,
          algorithm: ALGORITHM,
          verify_jti: proc { |jti|
            Jti.exists?(jti)
          }
        )

        _type, sub = GraphQL::Schema::UniqueWithinType.decode(payload['sub'], separator: ':')
        find(sub)
      end
    end
  end
end
