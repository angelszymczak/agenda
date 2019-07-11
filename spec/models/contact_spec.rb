# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'model validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:cell_phone) }
    it { is_expected.to validate_presence_of(:zip_code) }

    it { is_expected.to have_many(:activities).dependent(:destroy) }
  end

  describe 'database validations' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:cell_phone).of_type(:string) }
    it { is_expected.to have_db_column(:zip_code).of_type(:integer) }
  end

  describe 'when factory create a valid contact' do
    subject(:contact) { create(:contact) }

    it { is_expected.to be_valid }

    its(:first_name) { is_expected.to be_a(String) }
    its(:last_name) { is_expected.to be_a(String) }
    its(:cell_phone) { is_expected.to be_a(String) }
    its(:zip_code) { is_expected.to be_an(Integer) }

    its(:activities) { is_expected.to be_empty }

    context 'with activities' do
      subject(:with_activities) { create(:contact_with_activities) }

      it { is_expected.to be_valid }

      its(:activities) { is_expected.to all(be_an(Activity)) }
    end
  end

  describe 'when factory build a invalid contact' do
    it 'without first name' do
      expect(build(:contact, first_name: nil)).not_to be_valid
    end

    it 'without last name' do
      expect(build(:contact, last_name: nil)).not_to be_valid
    end

    it 'without cell phone' do
      expect(build(:contact, cell_phone: nil)).not_to be_valid
    end

    it 'without zip code' do
      expect(build(:contact, zip_code: nil)).not_to be_valid
    end
  end
end
