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
    @user = current_user
    @was = @user.balance
    @transaction = Transaction.new(:name=>params[:transaction][:name], :price=>params[:transaction][:price],
                                   :kind_id=>params[:transaction][:kind_id], :user_id=>@user.id)

    if @was>params[:transaction][:price].to_f
        if @transaction.save
          @user.update_attributes(balance: @was - params[:transaction][:price].to_f)
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

  def edit
    @user = current_user
    @transaction = Transaction.find(params[:id])
  end
  def update
    @user = current_user
    @balance_was = @user.balance
    @transaction = Transaction.find(params[:id])
    @transaction_price_was = @transaction.price
    if @transaction.update_attributes(transaction_params)
      @user.update_attributes(balance: @balance_was + @transaction_price_was - params[:transaction][:price].to_f )
      # Handle a successful update.
      flash[:success] = "Transaction updated"
      redirect_to transactions_url
    else
      render 'edit'
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

  def data_filer_show
    if params['start'] =~ /[0-3]{1}[0-9]{1}\/[0-1]{1}[0-9]{1}\/[1-2]{1}[0-9]{3}/ && params['end'] =~ /[0-3]{1}[0-9]{1}\/[0-1]{1}[0-9]{1}\/[1-2]{1}[0-9]{3}/ && DateTime.parse(params['end'])>=DateTime.parse(params['start'])
      start_date = DateTime.parse(params['start'])
      end_date = DateTime.parse(params['end'])
      @transaction = Transaction.where(["created_at >= ? AND created_at <=?", start_date, end_date]).paginate(
                                                           :page => params[:page],
                                                           :per_page => 15).order('id DESC')
    @new = Transaction.new()
    @user = current_user
    render 'index'
    else
      flash[:danger] = "Wrong date format"
      redirect_to transactions_url
    end
  end

  def category_filter_show
    @transaction = Transaction.where(:kind_id => params[:transaction][:kind_id]).paginate(:page => params[:page], :per_page => 15).order('id DESC')
    @new = Transaction.new()
    @user = current_user
    render 'index'
  end

  def money_filter_show
     arr=[]
    if params[:price] == "0"
      arr=[1000, 4000]
    else
      arr = params[:price].split(',')
    end
      @transaction = Transaction.where(["price >= ? AND price <=?", arr.first, arr.last]).paginate(:page => params[:page], :per_page => 15).order('id DESC')
      @new = Transaction.new()
      @user = current_user
      render 'index'
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

  def transaction_params
      params.require(:transaction).permit(:name, :price, :kind, :kind_id)
  end

  def validate_end_date_before_start_date
    if end_date && start_date
      errors.add(:end_date, "Put error text here") if end_date < start_date
    end
  end
end
