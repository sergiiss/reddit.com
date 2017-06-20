class VoteDownsController < ApplicationController
  before_action :find_post, only: [ :create, :destroy ]

  def new
    @vote_down = VoteDown.new
  end

  def create
    @vote_down = @post.vote_downs.create(vote_down_params.merge(:user_id => @current_user.id))

    @vote = @post.votes.find_by(:user_id => @current_user.id)

    if @vote
     @vote.destroy
    end

    redirect_to root_path
  end

  def destroy
    @vote_down = @post.vote_downs.find_by(:user_id => @current_user.id)

    @vote_down.destroy

    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def vote_down_params
    params.permit(:id, :post_id, :user_id)
  end
end
