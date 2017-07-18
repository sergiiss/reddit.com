class VotesController < ApplicationController
  def up
    find_post

    @post.vote_up(@current_user)

    redirect_to root_path
  end

  def down
    find_post

    @post.vote_down(@current_user)

    redirect_to root_path
  end

  def destroy
    find_post

    @vote = @post.votes.find_by(:user_id => @current_user.id, vote_type: ['up', 'down'])

    @vote.destroy

    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def vote_params
    params.permit(:id, :post_id, :user_id, :vote_type)
  end
end
