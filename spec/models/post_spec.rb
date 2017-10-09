require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    @user = FactoryGirl.create(:user)
    @post = FactoryGirl.build(:post, user: @user)
    it { should validate_presence_of(:user) }
  end

  context 'with valid attributes' do
    it "should be valid" do
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, user: @user)
      expect(@post).to be_valid
    end
  end

  context 'with invalid attributes' do
    it "shuld be invalid" do
      @post = FactoryGirl.build(:post, user: nil)
      expect(@post).to_not be_valid
    end
  end
end
