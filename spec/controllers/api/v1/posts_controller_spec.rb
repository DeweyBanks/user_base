require 'rails_helper'

RSpec.describe Api::V1::PostsController, :type => :controller do
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      @post = FactoryGirl.create :post, user: @user
      get :show, id: @post.id, format: :json
    end

    it "returns the information about a post" do
      post_response = JSON.parse(response.body, symbolize_names: true)
      expect(post_response[:title]).to eql @post.title
    end

    it { should respond_with 200 }
  end

end




