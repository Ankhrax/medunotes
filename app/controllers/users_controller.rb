class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [ :new, :create ]
  before_action :require_authentication, only: [ :edit, :update, :show, :destroy ]
  def new
    @user = User.new
  end

  def show
    @user=Current.user
  end

  def create
    if User.exists?(email_address: user_params[:email_address])
      flash.now[:alert] = t("user.email_taken")
      @user = User.new(user_params)
      render :new, status: :unprocessable_entity
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: t("user.created")
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @user = Current.user
  end


  def update
    @user = Current.user
    if user_params[:email_address] == @user.email_address
      redirect_to root_path
    elsif User.exists?(email_address: user_params[:email_address])
      flash.now[:alert] = t("user.email_taken")
      render :edit, status: :unprocessable_entity
    else
      if @user.update(user_params)
        redirect_to root_path, notice: t("user.account_updated")
      else
        render :edit
      end
    end
  end

  def destroy
    Current.user.destroy
    redirect_to root_path, notice: t("user.deleting_account")
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
