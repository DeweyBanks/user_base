require 'rails_helper'

describe Api::V1::PostsController, :type => :controller do

  before(:each) { request.headers['Accept'] = "application/vnd.user-base.v1" }

  describe "GET #show" do
    before(:each) do
      @post = FactoryGirl.create :post
      get :show, id: @post.id, format: :json
    end

    it "returns the information about a post" do
      post_response = JSON.parse(response.body, symbolize_names: true)
      expect(post_response[:title]).to eql @post.title
    end

    it { should respond_with 200 }
  end

end




