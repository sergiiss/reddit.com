class VoteTablesController < ApplicationController
  def up
    find_post

    @vote_table = @post.vote_tables.create(vote_table_params.merge(:user_id => @current_user.id, vote_type: 'up'))

    @vote_down = @post.vote_tables.find_by(:user_id => @current_user.id, vote_type: ['down'])

    if @vote_down
      @vote_down.destroy
    end

    redirect_to root_path
  end

  def down
    find_post

    @vote_table = @post.vote_tables.create(vote_table_params.merge(:user_id => @current_user.id, vote_type: 'down'))

    @vote_up = @post.vote_tables.find_by(:user_id => @current_user.id, vote_type: ['up'])

    if @vote_up
      @vote_up.destroy
    end

    redirect_to root_path
  end

  def destroy
    find_post

    @vote_table = @post.vote_tables.find_by(:user_id => @current_user.id, vote_type: ['up', 'down'])

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
