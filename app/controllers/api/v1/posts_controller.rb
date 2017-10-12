class Api::V1::PostsController < ApplicationController
  respond_to :json

  def index
    respond_with Post.all
  end

  def show
    post = Post.find(params[:id])
    if post
      respond_with post
    else
      render json: {errors: "Post not found"}, status: 404
  end

  def create
    binding.pry
    post = current_user.posts.build(post_params)
    if post.save
      render json: post, status: 201, location: [:api, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :user)
  end
end
