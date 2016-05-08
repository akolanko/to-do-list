class ItemsController < ApplicationController

  helper_method :sort_attribute, :sort_direction

  def index
    @items = Item.order(sort_attribute + ' ' + sort_direction)
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.update_attributes(completed: false)
    if @item.save
      flash[:notice] = "Task added successfully."
      redirect_to home_path
    else
      flash[:alert] = "There was a problem adding your task."
      redirect_to :back
    end
  end

  def update
    @item = Item.where(id: params[:id]).first
    @item.toggle(:completed)
    if @item.save
      if @item.completed == true
        flash[:notice] = "Task completed! Way to go!"
      elsif @item.completed == false
        flash[:notice] = "Task added back to list."
      end
      redirect_to home_path
    else
      flash[:alert] = "There was a problem updating the information."
      redirect_to :back
    end
  end

  def destroy
    @item = Item.where(id: params[:id]).first
    if @item && @item.destroy
      flash[:notice] = "Task deleted successfully."
      redirect_to home_path
    else
      flash[:alert] = "There was a problem deleting your task."
      redirect_to :back
    end
  end

  private
  def item_params
    params.require(:item).permit(:task, :completed)
  end

  def sort_attribute
    Item.column_names.include?(params[:sort]) ? params[:sort] : "completed"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
