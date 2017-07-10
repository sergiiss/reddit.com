class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [ :new, :create ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    set_user
  end

  def update
    set_user
  end

  def edit
    set_user
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        input_user_to_session
        format.html { redirect_to @user, notice: 'Пользователь был успешно создан.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_user

    if current_user.name == 'admin'
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'Пользователь был успешно удален.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :id)
  end
end
