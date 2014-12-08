class KindsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  def new
    @kind = Kind.new()
  end

  def create
    user = current_user
    @kind = Kind.new(:name=>params[:kind][:name], :user_id=>user.id)
    if @kind.save
      # Handle a successful save.
      flash[:success] = "New category added"
      redirect_to kinds_url
    else
      render 'new'
    end
  end

  def index
    @user = current_user
    @new = Kind.new()
    @kind = Kind.where(:user_id => @user.id).paginate(:page => params[:page], :per_page => 15).order('id DESC')
  end

  def destroy
    @kind = Kind.find(params[:id]).destroy
    flash[:success] = "Category deleted successfully"
    redirect_to kinds_url
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
end
