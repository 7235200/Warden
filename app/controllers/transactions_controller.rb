class TransactionsController < ApplicationController
  before_action :logged_in_user

  def new
    @transaction = Transaction.new()
  end

  def index
    @user = current_user
    @new = Transaction.new()
    @transaction = Transaction.where(:user_id => @user.id).paginate(:page => params[:page], :per_page => 15).order('id DESC')

  end

  def create
    user = current_user
    was = user.balance
    @transaction = Transaction.new(:name=>params[:transaction][:name], :price=>params[:transaction][:price],
                                   :kind_id=>params[:transaction][:kind_id], :user_id=>user.id)

    if was>params[:transaction][:price].to_f
        if @transaction.save
          user.update_attributes(balance: was - params[:transaction][:price].to_f)
          # Handle a successful save.
          flash[:success] = "New category added"
          redirect_to transactions_url
        else
          render 'new'
        end
    else
      flash[:danger] = "payment cant be higher than your balance"
      redirect_to transactions_url
    end
   end

  def destroy
    @transaction = Transaction.find(params[:id])
    user = current_user
    was = user.balance
    user.update_attributes(balance: was + @transaction.price)
    @transaction.destroy
    flash[:success] = "Transaction deleted successfully"
    redirect_to transactions_url
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

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
