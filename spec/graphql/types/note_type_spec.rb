# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::NoteType do
  subject { described_class }

  describe 'execute' do
    subject(:execute) do
      AppSchema.execute(query, context: context, variables: variables).to_h.deep_symbolize_keys
    end
    let!(:account) { create(:account) }
    let(:note) { create(:note) }
    let(:context) { { current_account: account } }
    let(:variables) { { id: note_id } }
    let(:query) do
      <<~GRAPHQL
        query GetNote($id: ID!) {
          node(id: $id) {
            ... on Note {
              id
            }
          }
        }

      GRAPHQL
    end

    context '正常系' do
      let(:note_id) { id_for(note, Types::NoteType, {}) }

      it 'OK' do
        res = execute
        expect(res[:errors]).to eq nil
        expect(res[:data][:node][:id]).to eq note_id
      end
    end
  end
end
