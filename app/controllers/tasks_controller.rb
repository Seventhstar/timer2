class TasksController < ApplicationController

  def index
    @items  = Task.order(:name)  
    @item = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "удален"
    redirect_to tasks_url
  end

  private

    def task_params
      params.require(:task).permit(:name)
    end
end

