class KindsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  def new
    @kind = Kind.new()
  end

  def create
    @user = current_user
    if @user.id != 1
      @kind = Kind.new(:name=>params[:kind][:name], :user_id=>@user.id, :isRequire=>params[:kind][:isRequire])
      if @kind.save
        # Handle a successful save.
        flash[:success] = "New category added"
        redirect_to kinds_url
      else
        render 'new'
      end
    else
      flash[:info] = "Are yor ready to sign up the Warden? Log out this awesome test user if you are!"
      redirect_to kinds_url
    end
  end

  def index
    @user = current_user
    @new = Kind.new()
    @kind = Kind.where(:user_id => @user.id).paginate(:page => params[:page], :per_page => 15).order('id DESC')
  end

  def edit
    @user = current_user
    @kind = Kind.find(params[:id])
  end
  def update
    @user = current_user
    if @user.id != 1
      @kind = Kind.find(params[:id])
      if @kind.update_attributes(kind_params)
        # Handle a successful update.
        flash[:success] = "Category updated"
        redirect_to kinds_url
      else
        render 'edit'
      end
    else
      flash[:info] = "Are yor ready to sign up the Warden? Log out this awesome test user if you are!"
      redirect_to kinds_url
    end
end

  def destroy
    @user = current_user
    if @user.id != 1
    @kind = Kind.find(params[:id]).destroy
    flash[:success] = "Category deleted successfully"
    redirect_to kinds_url
  else
    flash[:info] = "Are yor ready to sign up the Warden? Log out this awesome test user if you are!"
    redirect_to kinds_url
  end
  end

  private
  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
    def kind_params
      params.require(:kind).permit(:name, :isRequire)
    end
end
