# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Auth::AuthenticationController, type: :request do
  subject(:payload) { response.parsed_body.with_indifferent_access }

  describe 'POST /sign_in ' do
    context 'when send valid params' do
      before { post '/sign_in', params: { authentication: authentication_params } }

      let(:authentication_params) { { email: user.email, password: user.password } }
      let!(:user) { create(:user) }

      it { expect(response).to have_http_status(:ok) }

      it { expect(payload[:token].split('.').first).to eq(token_generator(user.id).split('.').first) }
    end

    context 'when send invalid params' do
      before { post '/sign_in', params: { authentication: { email: 'invalid@email.com', password: 'invalid' } } }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
