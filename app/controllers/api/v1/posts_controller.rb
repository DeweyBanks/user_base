class Api::V1::PostsController < ApplicationController
      respond_to :json

      def index
        @posts = Post.all
      end

      def show
        respond_with Post.find(params[:id])
      end
end
