class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [ :new, :create]
  before_action :require_authentication, only: [:edit, :update, :show, :destroy] 
  def new
    @user = User.new
  end

  def show
    @user=Current.user

  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: t('user.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = Current.user
  end
  

  def update
    @user = Current.user
    if @user.update(user_params)
      redirect_to root_path, notice: t('user.account_updated')
    else
      render :edit
    end
  end

  def destroy
    Current.user.destroy
    redirect_to root_path, notice:
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
