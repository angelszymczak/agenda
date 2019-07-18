# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
  end

  describe 'database validations' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string) }
  end

  describe 'when factory create a valid user' do
    subject(:user) { create(:user) }

    it { is_expected.to be_valid }

    its(:email) { is_expected.to be_a(String) }
    its(:password) { is_expected.to be_a(String) }
  end

  describe 'when factory build a invalid user' do
    it 'without email' do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it 'without password' do
      expect(build(:user, password: nil)).not_to be_valid
    end

    it 'without password confirmation' do
      expect(build(:user, password_confirmation: nil)).not_to be_valid
    end
  end
end
