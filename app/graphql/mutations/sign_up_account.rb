# frozen_string_literal: true
module Mutations
  # サインアップMutation
  class SignUpAccount < BaseMutation
    field :account, Types::AccountType, null: false
    field :token, String, null: false

    argument :username, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true
    argument :avatar_url, String, required: false

    def resolve(**args)
      fail '2つのパスワードが一致してない' unless args[:password] == args[:password_confirmation]

      account = Account.create!(args.except(:password_confirmation))
      AccountMailer.send_email_verification(account.id).deliver_later
      account.email_verification_status_requested!

      { account: account, token: account.jwt }
    end
  end
end
