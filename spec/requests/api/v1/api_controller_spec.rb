# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ApiController, type: :request do
  describe '#authorize' do
    let!(:user) { create(:user) }

    let(:headers) { { 'Authorization' => token_generator(user.id) } }
    let(:invalid_headers) { { 'Authorization' => nil } }

    context 'when auth token es passed' do
      before { allow_any_instance_of(described_class).to receive_message_chain(:request, :headers) { headers } }

      it 'sets the current user' do
        expect(subject.instance_eval { authorize }).to be_nil
        expect(Current.user).to eq(user)
      end
    end

    context 'when auth token is not passed' do
      before { allow_any_instance_of(described_class).to receive_message_chain(:request, :headers) { invalid_headers } }

      it 'raises a missing token error' do
        expect { subject.instance_eval { authorize } }
          .to raise_error(Api::V1::Concerns::ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end
