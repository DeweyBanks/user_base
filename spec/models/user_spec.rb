require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validations' do
    before { @user = FactoryGirl.build(:user) }
    it { is_expected.to validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  context 'with valid attributes' do
    before { @user = FactoryGirl.build(:user) }
    subject {@user}
    it { is_expected.to be_valid }
  end

  context 'with invalid attributes' do
     before { @user = FactoryGirl.build(:user, email: "") }
     subject {@user}
     it { is_expected.to be_invalid }
  end
end
