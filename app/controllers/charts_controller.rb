class ChartsController < ApplicationController
  def index
    @user=current_user
    @transaction = Transaction.unscoped.where(:user_id => @user.id)
  end

  def three_month
   @user=current_user
   @current_user_transaction = Transaction.unscoped.where(:user_id => @user.id)
   @transaction = @current_user_transaction.where(["created_at::date >= ?", 3.month.ago])
   render 'index'
  end

   def month
    @user=current_user
    @current_user_transaction = Transaction.unscoped.where(:user_id => @user.id)
    @transaction = @current_user_transaction.where(["created_at::date >= ?", 1.month.ago])
    render 'index'
   end

   def today
    @user=current_user
    @current_user_transaction = Transaction.unscoped.where(:user_id => @user.id)
    @transaction = @current_user_transaction.where(["created_at::date = ?", Date.today])
    render 'index'
   end
end
