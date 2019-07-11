# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'model validations' do
    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_presence_of(:contact) }
    it { is_expected.to belong_to(:contact) }
  end

  describe 'database validations' do
    it { is_expected.to have_db_column(:description).of_type(:string) }
    it { is_expected.to have_db_column(:contact_id).of_type(:integer) }
  end

  describe 'when factory create a valid activity' do
    subject(:activity) { create(:activity) }

    it { is_expected.to be_valid }

    its(:description) { is_expected.to be_a(String) }

    its(:contact) { is_expected.to be_a(Contact) }
  end

  describe 'when facotry build a invalid activity' do
    it 'without description' do
      expect(build(:activity, description: nil)).not_to be_valid
    end

    it 'without contact' do
      expect(build(:activity, contact: nil)).not_to be_valid
    end
  end
end
