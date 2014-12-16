class TransactionsController < ApplicationController
  before_action :logged_in_user

  def new
    @transaction = Transaction.new()
  end

  def index
    @require_kinds_names = []
    @kinds_names_from_transactions = []
    @foo = []
    @user = current_user
    @new = Transaction.new()
    @transaction_before = Transaction.where(:user_id => @user.id)
    @transaction = @transaction_before.paginate(:page => params[:page], :per_page => 15).order('id DESC')

    @transaction_remaining = @transaction_before.where(["created_at >= ?", 1.month.ago])

    @arr = Kind.where(:user_id=>@user.id)
    @require_kinds = @arr.where(:isRequire => true)

    @require_kinds.each do |f|
      @require_kinds_names << f.name
    end

    @transaction_remaining.each do |f|
    @kinds_names_from_transactions << f.kind_name
    end

    @require_kinds_names.each do |name|
      if !@kinds_names_from_transactions.include?(name)
        @foo << name
      end
    end
   end


  def create
    @user = current_user
    if @user.id != 1
    @was = @user.balance
    @kind_id = params[:transaction][:kind_id]
    @kind_name = Kind.find(@kind_id).name
    @transaction = Transaction.new(:name=>params[:transaction][:name], :price=>params[:transaction][:price],
                                   :kind_id=>params[:transaction][:kind_id], :user_id=>@user.id,
     :kind_name=>@kind_name)

    if @was>params[:transaction][:price].to_f
        if @transaction.save
          @user.update_attributes(balance: @was - params[:transaction][:price].to_f)
          # Handle a successful save.
          flash[:success] = "New transaction added"
          redirect_to transactions_url
        else
          render 'new'
        end
    else
      flash[:danger] = "payment cant be higher than your balance"
      redirect_to transactions_url
    end
    else
      flash[:info] = "Are yor ready to sign up the Warden? Log out this awesome test user if you are!"
      redirect_to transactions_url
    end
   end

  def edit
    @user = current_user
    @transaction = Transaction.find(params[:id])
  end

  def update
    @user = current_user
    if @user.id != 1
    @balance_was = @user.balance
    @transaction = Transaction.find(params[:id])
    @transaction_price_was = @transaction.price
    @kind_id = params[:transaction][:kind_id]
    @kind_name = Kind.find(@kind_id).name

    if @transaction.update_attributes(transaction_params)
      @user.update_attributes(balance: @balance_was + @transaction_price_was - params[:transaction][:price].to_f )
      @transaction.update_attributes(:kind_name=>@kind_name)
      # Handle a successful update.
      flash[:success] = "Transaction updated"
      redirect_to transactions_url
    else
      render 'edit'
    end
    else
      flash[:info] = "Are yor ready to sign up the Warden? Log out this awesome test user if you are!"
      redirect_to transactions_url
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    user = current_user
    if user.id != 1
    was = user.balance
    user.update_attributes(balance: was + @transaction.price)
    @transaction.destroy
    flash[:success] = "Transaction deleted successfully"
    redirect_to transactions_url
    else
      flash[:info] = "Are yor ready to sign up the Warden? Log out this awesome test user if you are!"
      redirect_to transactions_url
    end
  end

  def data_filer_show
    @user = current_user
    @new = Transaction.new()
    if params['start'] =~ /[0-3]{1}[0-9]{1}\/[0-1]{1}[0-9]{1}\/[1-2]{1}[0-9]{3}/ && params['end'] =~ /[0-3]{1}[0-9]{1}\/[0-1]{1}[0-9]{1}\/[1-2]{1}[0-9]{3}/ && DateTime.parse(params['end'])>=DateTime.parse(params['start'])
      start_date = DateTime.parse(params['start'])
      end_date = DateTime.parse(params['end'])
      @transaction = Transaction.where(["created_at >= ? AND created_at <=? AND user_id =?", start_date, end_date, @user.id]).paginate(
                                                           :page => params[:page],
                                                           :per_page => 15).order('id DESC')
      render 'index'
    else
      flash[:danger] = "Wrong date format"
      redirect_to transactions_url
    end
  end

  def category_filter_show
    @new = Transaction.new()
    @user = current_user
    @transaction = Transaction.where(["kind_id = ? AND user_id =?", params[:transaction][:kind_id], @user.id]).paginate(:page => params[:page], :per_page => 15).order('id DESC')
    render 'index'
  end

  def money_filter_show
     arr=[]
    if params[:price] == "0"
      arr=[1000, 4000]
    else
      arr = params[:price].split(',')
    end
     @new = Transaction.new()
     @user = current_user
      @transaction = Transaction.where(["price >= ? AND price <=? AND user_id =?", arr.first, arr.last, @user.id]).paginate(:page => params[:page], :per_page => 15).order('id DESC')
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
