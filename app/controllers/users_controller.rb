class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  # skip_before_filter :verify_authenticity_token, :only => [:add_money]

  def new
    @user = User.new()
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # redirect_to @user
      redirect_to kinds_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.id != 1
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to root_url
    else
      render 'edit'
    end
    else
      flash[:info] = "Are yor ready to sign up the Warden? Log out this awesome test user if you are!"
      redirect_to transactions_url
    end
  end


  def recharge
    @user = current_user
  end

  def add_money
    @user = current_user
    if @user.id != 1
    was = @user.balance
    if  @user.update_attributes(balance: params[:user][:balance])
        @user.update_attributes(balance: @user.balance + was)
        flash[:success] = "Balance recharged"
        redirect_to root_url
    else
        @user.balance = was
        render 'users/_recharge'
    end
    else
      flash[:info] = "Are yor ready to sign up the Warden? Log out this awesome test user if you are!"
      redirect_to transactions_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :balance)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  def test_user
    @user = User.find(:id=>1)
    redirect_to(root_url) unless current_user?(@user)
  end
end
