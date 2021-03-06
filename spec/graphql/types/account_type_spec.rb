# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::AccountType do
  subject { described_class }

  describe 'execute' do
    subject(:execute) do
      AppSchema.execute(query, context: context, variables: variables).to_h.deep_symbolize_keys
    end
    let!(:account) { create(:account) }
    let(:context) { { current_account: account } }
    let(:variables) { { id: account_id } }
    let(:query) do
      <<~GRAPHQL
        query GetAccount($id: ID!) {
          node(id: $id) {
            ... on Account {
              id
            }
          }
        }

      GRAPHQL
    end

    context '正常系' do
      let(:account_id) { id_for(account, Types::AccountType, {}) }

      it 'OK' do
        res = execute
        expect(res[:errors]).to eq nil
        expect(res[:data][:node][:id]).to eq account_id
      end
    end
  end
end
