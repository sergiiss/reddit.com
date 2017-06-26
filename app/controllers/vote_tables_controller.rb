class VoteTablesController < ApplicationController
  before_action :find_post, only: [ :create, :destroy, :up, :down ]

  def new
    @vote_table = VoteTable.new
  end

  def up
    @vote_table = @post.vote_table.create(vote_table_params.merge(:user_id => @current_user.id, vote_type: 'up'))

    @vote_down = @post.vote_table.find_by(:user_id => @current_user.id, vote_type: ['down'])

    if @vote_down
      @vote_down.destroy
    end

    redirect_to root_path
  end

  def down
    @vote_table = @post.vote_table.create(vote_table_params.merge(:user_id => @current_user.id, vote_type: 'down'))

    @vote_up = @post.vote_table.find_by(:user_id => @current_user.id, vote_type: ['up'])

    if @vote_up
      @vote_up.destroy
    end

    redirect_to root_path
  end

  def create
  end

  def destroy
    @vote_table = @post.vote_table.find_by(:user_id => @current_user.id, vote_type: ['up', 'down'])

    @vote_table.destroy

    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def vote_table_params
    params.permit(:id, :post_id, :user_id, :vote_type)
  end
end
