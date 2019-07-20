# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ActivitiesController, type: :request do
  subject(:payload) { response.parsed_body.with_indifferent_access[:data] }

  let(:headers) { valid_headers }

  let(:contact) { create(:contact) }

  describe 'GET /contacts/{id}/activities' do
    context 'when have activities' do
      let!(:samples) { create_list(:activity, 5, contact: contact) }

      before { get "/contacts/#{contact.id}/activities", headers: headers }

      it { expect(response).to have_http_status(:ok) }

      it { is_expected.to all(have_type('activities')) }

      it 'recovers all activity stored' do
        expect(payload.map { |record| record[:id] }.sort).to match_array(samples.map(&:id).sort.map(&:to_s))
      end
    end

    context 'when have not activities' do
      before { get "/contacts/#{contact.id}/activities", headers: headers }

      it { expect(response).to have_http_status(:ok) }

      it { is_expected.to be_empty }
    end
  end

  describe 'POST /contacts/{id}/activities' do
    context 'when send valid params' do
      before do
        post "/contacts/#{contact.id}/activities",
             params: { activity: activity_params }.to_json,
             headers: headers
      end

      let(:activity_params) { attributes_for(:activity) }

      it { expect(response).to have_http_status(:created) }

      it do
        expect(payload)
          .to have_type('activities')
          .and have_attribute(:description)
          .with_value(activity_params[:description])
          .and have_relationship(:contact)
          .with_data('id' => contact.id.to_s, 'type' => 'contacts')
      end
    end

    context 'when send invalid params' do
      before do
        post "/contacts/#{contact.id}/activities",
             params: { activity: { description: '' } }.to_json,
             headers: headers
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PUT /contacts/{id}/activities/{id}' do
    let!(:sample) { create(:activity, contact: contact) }

    context 'when send valid params' do
      before do
        put "/contacts/#{contact.id}/activities/#{sample.id}",
            params: { activity: update_params }.to_json,
            headers: headers
      end

      let(:update_params) { { description: Faker::TvShows::RickAndMorty.quote } }

      it { expect(response).to have_http_status(:ok) }

      it do
        expect(payload)
          .to have_type('activities')
          .and have_attribute(:description)
          .with_value(update_params[:description])
          .and have_relationship(:contact)
          .with_data('id' => contact.id.to_s, 'type' => 'contacts')
      end
    end

    context 'when sample not exists' do
      before do
        put "/contacts/#{contact.id}/activities/9999",
            params: { activity: { description: '' } }.to_json,
            headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when send invalid params' do
      before do
        put "/contacts/#{contact.id}/activities/#{sample.id}",
            params: { activity: { description: '' } }.to_json,
            headers: headers
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE /activities/{:id}' do
    context 'when send valid params' do
      let!(:sample) { create(:activity, contact: contact) }

      before { delete "/contacts/#{contact.id}/activities/#{sample.id}", headers: headers }

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'when sample not exists' do
      before { delete "/contacts/#{contact.id}/activities/9999", headers: headers }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
