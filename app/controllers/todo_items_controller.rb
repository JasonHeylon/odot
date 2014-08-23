class TodoItemsController < ApplicationController

  before_action :find_todo_list
  before_action :find_todo_items, only: [:edit, :update, :destroy, :complete]


  def index
  	
  end

  def new
  	@todo_item = @todo_list.todo_items.new
  end

  def create
  	@todo_item = @todo_list.todo_items.new(todo_item_params)
  	if @todo_item.save
  		flash[:success] = "Added todo list item."
  		redirect_to todo_list_todo_items_path
  	else
  		flash[:error] = "There was a problem adding that todo list item."

  		render 'new'
  	end
  end

  def edit

  end


  def update

    if @todo_item.update(todo_item_params)
      flash[:success] = "Saved todo list item"
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "That todo item counld not be save."
      render 'edit'
    end
    
  end


  def url_options
    { todo_list_id: params[:todo_list_id] }.merge(super)
    
  end


  def destroy
    if @todo_item.destroy
      flash[:success] = "Todo list item was deleted."
    else
      flash[:error] = "Todo list ite could not be deleted."
    end
    
    redirect_to todo_list_todo_items_path
  end


  def complete
    @todo_item.update(completed_at: Time.now)
    redirect_to todo_list_todo_items_path, notice: "Todo item marked as complete."
  end



  private


    def find_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def find_todo_items
      @todo_item = @todo_list.todo_items.find(params[:id])
    end

  	def todo_item_params
  		params[:todo_item].permit(:content)
  	end

end
