# frozen_string_literal: trus

require 'rails_helper'

RSpec.describe Api::V1::Auth::RegistrationController, type: :request do
  subject(:payload) { response.parsed_body.with_indifferent_access }

  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: { user: attributes_for(:user) } }

      it { expect(response).to have_http_status(:created) }

      its([:message]) { is_expected.to match(/Account created successfully/) }
      its([:token]) { is_expected.not_to be_blank }
    end

    context 'when invalid request' do
      before { post '/signup', params: { user: { email: '' } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }

      its([:errors]) { is_expected.to match(/Validation failed/) }
    end
  end
end
