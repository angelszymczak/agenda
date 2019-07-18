# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  describe '#call' do
    let(:user) { create(:user) }

    context 'when valid token' do
      subject(:auth) { described_class.new('Authorization' => token_generator(user.id)).call }

      it { is_expected.to be_a(described_class) }

      its(:result) { is_expected.to eq(user) }
    end

    context 'when invalid token' do
      it 'raises a missing token error' do
        expect { described_class.new('Authorization' => nil).call }
          .to raise_error(
            Api::V1::Concerns::ExceptionHandler::MissingToken,
            /Missing token/
          )
      end

      it 'raises an invalid token error by expiration time' do
        expect { described_class.new('Authorization' => expired_token_generator(user.id)).call }
          .to raise_error(
            Api::V1::Concerns::ExceptionHandler::InvalidToken,
            /Invalid token Signature has expired/
          )
      end

      it 'raises an invalid token error' do
        expect { described_class.new('Authorization' => 'invalid').call }
          .to raise_error(
            Api::V1::Concerns::ExceptionHandler::InvalidToken,
            /Invalid token Not enough or too many segments/
          )
      end

      it 'raises an invalid token error data' do
        expect { described_class.new('Authorization' => token_generator(100)).call }
          .to raise_error(
            Api::V1::Concerns::ExceptionHandler::InvalidToken,
            /Invalid token Couldn't find User with 'id'=100/
          )
      end
    end
  end
end
