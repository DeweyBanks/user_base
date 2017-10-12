require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    before { @user = FactoryGirl.build(:user) }
    it { is_expected.to validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:auth_token)}
    it { should have_many(:posts) }
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

  describe "#posts association" do
     before { @user = FactoryGirl.build(:user) }
     subject { @user }
    before do
      @user.save
      3.times { FactoryGirl.create :post, user: @user }
    end

    it "destroys the associated products on self destruct" do
      posts = @user.posts
      @user.destroy
      posts.each do |post|
        expect{Post.find(post.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#generate_authentication_token!" do
    before { @user = FactoryGirl.build(:user) }
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
