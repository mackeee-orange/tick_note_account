# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateTag do
  subject { described_class }

  describe 'execute' do
    subject(:execute) do
      AppSchema.execute(mutation, context: {}, variables: variables).to_h.deep_symbolize_keys
    end
    let(:mutation) do
      <<~GRAPHQL
        mutation CreateTag($input: CreateTagInput!) {
          createTag(input: $input) {
            tag {
              id
            }
          }
        }
      GRAPHQL
    end
    let(:variables) do
      { input: {
        name: "hoge"
      } }
    end
    let(:new_tag) { build(:tag) }

    context '正常' do
      it 'OK' do
        res = execute
        expect(res[:errors]).to eq nil
      end
    end
  end
end
