class VotesController < ApplicationController
  before_action :find_post, only: [ :create, :destroy ]

  def new
    @vote = Vote.new
  end

  def create
    @vote = @post.votes.create(vote_params.merge(:user_id => @current_user.id))

    redirect_to root_path
  end

  def destroy
    @vote = @post.votes.find_by(:user_id => @current_user.id)
    @vote.destroy

    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def vote_params
    params.permit(:id, :post_id, :user_id)
  end
end

