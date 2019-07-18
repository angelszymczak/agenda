# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUser do
  describe '#call' do
    context 'when valid credentials' do
      subject(:auth) { described_class.new(user.email, user.password).call }

      let(:user) { create(:user) }

      it { is_expected.to be_a(described_class) }

      its(:result) { is_expected.to be_a(String) }
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { described_class.new(:invalid, :credential).call }
          .to raise_error(Api::V1::Concerns::ExceptionHandler::AuthenticationError, /Invalid credentials/)
      end
    end
  end
end
