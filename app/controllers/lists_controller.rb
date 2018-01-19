class ListsController < ApplicationController
  before_action :set_photo, :only => [:show, :edit, :update, :expire?, :destroy]
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_url
    else
      render :action => :new
    end
  end

  def update
    if @list.update_attributes(list_params)
      redirect_to lists_path(@list)
    else
      render :action => :edit
    end
  end

  def expire?
    if @list.due_date < Time.now
      return true
    else
      return false
    end
  end

  def destroy
    if !expire?
      @list.destroy

      redirect_to lists_url
    end
  end

  

  private

  def set_photo
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :due_date, :note)
  end
end
