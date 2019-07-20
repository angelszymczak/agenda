# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :request do
  subject(:payload) { response.parsed_body.with_indifferent_access[:data] }

  let(:headers) { valid_headers }

  describe 'GET /contacts' do
    context 'when have contacts' do
      let!(:samples) { create_list(:contact, 5) }

      before { get '/contacts', headers: headers }

      it { expect(response).to have_http_status(:ok) }

      it { is_expected.to all(have_type('contacts')) }

      it 'recovers all contact stored' do
        expect(payload.map { |record| record[:id] }.sort).to match_array(samples.map(&:id).sort.map(&:to_s))
      end
    end

    context 'when have not contacts' do
      before { get '/contacts', headers: headers }

      it { expect(response).to have_http_status(:ok) }

      it { is_expected.to be_empty }
    end
  end

  describe 'GET /contacts/{id}' do
    context 'when sample exists' do
      let!(:sample) { create(:contact) }

      before { get "/contacts/#{sample.id}", headers: headers }

      it { expect(response).to have_http_status(:ok) }

      it do
        expect(payload)
          .to have_type('contacts')
          .and have_id(sample.id.to_s)
      end
    end

    context 'when sample not exists' do
      before { get '/contacts/9999', headers: headers }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /contacts' do
    context 'when send valid params' do
      before { post '/contacts', params: { contact: contact_params }.to_json, headers: headers }

      let(:contact_params) { attributes_for(:contact) }

      it { expect(response).to have_http_status(:created) }

      it do
        expect(payload)
          .to have_type('contacts')
          .and have_attribute(:first_name)
          .with_value(contact_params[:first_name])
          .and have_attribute(:last_name)
          .with_value(contact_params[:last_name])
          .and have_attribute(:cell_phone)
          .with_value(contact_params[:cell_phone])
          .and have_attribute(:zip_code)
          .with_value(contact_params[:zip_code])
      end
    end

    context 'when send invalid params' do
      before { post '/contacts', params: { contact: { first_name: '' } }.to_json, headers: headers }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PUT /contacts/{id}' do
    let!(:sample) { create(:contact) }

    context 'when send valid params' do
      before { put "/contacts/#{sample.id}", params: { contact: update_params }.to_json, headers: headers }

      let(:update_params) do
        {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          cell_phone: Faker::PhoneNumber.valid_cell_phone,
          zip_code: Faker::Address.zip_code.to_i
        }
      end

      it { expect(response).to have_http_status(:ok) }

      it do
        expect(payload)
          .to have_type('contacts')
          .and have_id(sample.id.to_s)
          .and have_attribute(:first_name)
          .with_value(update_params[:first_name])
          .and have_attribute(:last_name)
          .with_value(update_params[:last_name])
          .and have_attribute(:cell_phone)
          .with_value(update_params[:cell_phone])
          .and have_attribute(:zip_code)
          .with_value(update_params[:zip_code])
      end
    end

    context 'when sample not exists' do
      before { put '/contacts/9999', params: { contact: { first_name: '' } }.to_json, headers: headers }

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when send invalid params' do
      before { put "/contacts/#{sample.id}", params: { contact: { first_name: '' } }.to_json, headers: headers }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE /contacts/{id}' do
    context 'when send valid params' do
      let!(:sample) { create(:contact) }

      before { delete "/contacts/#{sample.id}", headers: headers }

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'when sample not exists' do
      before { delete '/contacts/9999', headers: headers }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
