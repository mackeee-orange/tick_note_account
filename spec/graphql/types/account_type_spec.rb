# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::AccountType do
  subject { described_class }

  describe 'execute' do
    subject(:execute) do
      AppSchema.execute(query, context: context, variables: variables).to_h.deep_symbolize_keys
    end
    let!(:account) { create(:account) }
    let(:account_id) { id_for(account, described_class, {}) }
    let(:context) { { current_account: account } }
    let(:variables) { { id: account_id } }

    context '正常系' do
      let(:query) do
        <<-GRAPHQL
        fragment AccountDetail on Account {
          id
        }
        query GetAccount($id: ID!) {
          node(id: $id) {
            ...AccountDetail
          }
        }
        GRAPHQL
      end

      it 'OK' do
        res = execute
        expect(res[:errors]).to eq nil
        expect(res[:data][:node][:id]).to eq account_id
      end
    end
  end
end
