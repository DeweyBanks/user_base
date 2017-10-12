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

  describe "GET #index" do
    before { get :index }
    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @post_attributes = FactoryGirl.attributes_for :post
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, post: @post_attributes }
      end

      it "renders the json representation for the post record just created" do
        post_response = json_response
        expect(post_response[:title]).to eql @post_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_product_attributes = { title: "Invalid Attributes" }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, post: @invalid_product_attributes }
      end

      it "renders an errors json" do
        post_response = json_response
        expect(post_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        post_response = json_response
        expect(post_response[:errors]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

end




