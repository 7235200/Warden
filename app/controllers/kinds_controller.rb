class KindsController < ApplicationController
  def new
    @kind = Kind.new()
  end

  def create
    @kind = Kind.new(params.require(:kind).permit(:name))
    if @kind.save
      # Handle a successful save.
      flash[:success] = "New category added"
      redirect_to kinds_url
    else
      render 'new'
    end
  end

  def index
    @kinds = Kind.all
  end

  def destroy
    @kind = Kind.find(params[:id]).destroy
    flash[:success] = "Category deleted successfully"
    redirect_to kinds_url
  end


end
