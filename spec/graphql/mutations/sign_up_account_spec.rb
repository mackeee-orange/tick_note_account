# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SignUpAccount do
  subject { described_class }

  describe 'arguments' do
    it { is_expected.to accept_argument(:email).of_type('String!') }
    it { is_expected.to accept_argument(:password).of_type('String!') }
    it { is_expected.to accept_argument(:passwordConfirmation).of_type('String!') }
    it { is_expected.to accept_argument(:username).of_type('String!') }
    it { is_expected.to accept_argument(:avatarUrl).of_type('String') }
  end

  describe 'execute' do
    subject(:execute) do
      AppSchema.execute(mutation, context: {}, variables: variables).to_h.deep_symbolize_keys
    end
    let(:mutation) do
      <<~GRAPHQL
        mutation SignUp($input: SignUpAccountInput!) {
          signUpAccount(input: $input) {
            account {
              id
              emailVerificationStatus
            }
          }
        }
      GRAPHQL
    end
    let(:variables) do
      { input: {
        username: new_account.username,
        email: new_account.email,
        password: 'password',
        confirm_password: 'password'
      } }
    end
    let(:new_account) { build(:account) }

    context '正常' do
      it 'OK' do
        res = execute
        expect(res[:errors]).to eq nil
        expect(res[:data][:node][:emailVerificationStatus]).to eq 'REQUESTED'
      end
    end

    context 'すでに存在するユーザー' do
      let(:new_account) { create(:account) }

      it 'エラー' do
        res = execute
        expect(res[:errors]).not_to eq nil
      end
    end
  end
end
