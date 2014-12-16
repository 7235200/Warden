class PurposesController < ApplicationController
  def index
    @user = current_user
    @purpose = Purpose.where(:user_id => @user.id).paginate(:page => params[:page], :per_page => 15).order('id DESC')
  end


  def new
    @user = current_user
    @purpose = Purpose.new()
  end

  def create
    @user = current_user
    @purpose = Purpose.new(:name => params[:purpose][:name], :storage => params[:purpose][:storage], :user_id => @user.id, :money => params[:purpose][:money])
    if params[:purpose][:storage].to_f <= params[:purpose][:money].to_f
      if params[:purpose][:storage].to_f <= @user.balance
        if @purpose.save
          @user.update_attributes(:balance => @user.balance - params[:purpose][:storage].to_f)
          # Handle a successful save.
          flash[:success] = "New purpose added"
          redirect_to purposes_url
        else
          render 'new'
        end
      else
        flash[:danger] = "You don't wanna to have zero-balance, right?"
        redirect_to purposes_url
      end
    else
      flash[:danger] = "Your storage can't be creater than declared purpose money"
      redirect_to purposes_url
    end


  end
  def edit
    @user = current_user
    @purpose = Purpose.find(params[:id])
  end

  def update
    @user = current_user
    @purpose = Purpose.find(params[:id])
    if params[:purpose][:storage].to_f <= params[:purpose][:money].to_f
      if params[:purpose][:storage].to_f <= @user.balance + @purpose.storage
        if  @user.update_attributes(balance: @user.balance + @purpose.storage - params[:purpose][:storage].to_f) && @purpose.update_attributes(purpose_params)
          # Handle a successful update.
          flash[:success] = "Category updated"
          redirect_to purposes_url
        else
          render 'edit'
        end
      else
        flash[:danger] = "You don't wanna to have zero-balance, right?"
        redirect_to purposes_url
      end
  else
    flash[:danger] = "Your storage can't be creater than declared purpose money"
    redirect_to purposes_url
  end
end


  def recharge
    @user = current_user
    @purpose = Purpose.find(params[:purpose][:id])
  end

  def add_money
    @user = current_user
    @purpose = Purpose.find(params[:purpose][:id])
    was = @purpose.storage
    if params[:purpose][:storage].to_f + was <= @purpose.money
      if @purpose.update_attributes(storage: params[:purpose][:storage])
         @purpose.update_attributes(storage: @purpose.storage + was)
         @user.update_attributes(balance: @user.balance - params[:purpose][:storage].to_f)
         flash[:success] = "Storage recharged"
         redirect_to purposes_path
      else
         @purpose.storage = was
         @user.balance = user_was
         render 'new'
      end
    else
      flash[:danger] = "You don't wanna to have zero-balance, right?"
      redirect_to purposes_path
    end
  end

  def destroy
    @purpose = Purpose.find(params[:id])
    user = current_user
    was = user.balance
    user.update_attributes(balance: was + @purpose.storage)
    @purpose.destroy
    flash[:success] = "Purpose deleted successfully"
    redirect_to purposes_path
  end


  private

  def purpose_params
    params.require(:purpose).permit(:name, :money, :storage)
  end
end
