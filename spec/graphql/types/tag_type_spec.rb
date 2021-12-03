# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::TagType do
  subject { described_class }
  let!(:account) { create(:account) }
  let(:context) { { current_account: account } }

  describe 'execute' do
    subject(:execute) do
      AppSchema.execute(query, context: context, variables: variables).to_h.deep_symbolize_keys
    end
    let!(:tag) { create(:tag) }
    let(:variables) { { id: tag_id } }
    let(:query) do
      <<~GRAPHQL
        query GetTag($id: ID!) {
          node(id: $id) {
            ... on Tag {
              id
            }
          }
        }
      GRAPHQL
    end

    context '正常系' do
      let(:tag_id) { id_for(tag_id, Types::TagType, {}) }

      it 'OK' do
        res = execute
        expect(res[:errors]).to eq nil
        expect(res[:data][:node][:id]).to eq tag_id
      end
    end
  end
end
