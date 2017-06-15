class PostsController < ApplicationController
  skip_before_action :authenticate_user, only: [ :index, :show ]

  def index
    @posts = Post.all
    @link_number = 0
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params.merge(:user_id => current_user.id))

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image, :user_id)
  end
end
