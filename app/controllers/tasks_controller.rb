class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all.order(created_at: :desc)
    if params[:sort_expired] == "true"  
      @tasks = Task.all.order(deadline: :ASC)

    elsif params[:sort_priority] == "true"
     @tasks = Task.all.order(priority: :DESC)

    elsif params[:task]
      name = params[:task][:name]
      progress = params[:task][:progress]
      @tasks = Task.search_name(name).search_progress(progress)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
    @tasks = @tasks.page(params[:page]).per(5)# = Task.new.page(params[:page]).per(10)


    # if params[:task].present?
    #   if params[:task][:name].present? && params[:task][:progress].present?
    #     @tasks = Task.search_task(@task_name)
    #   elsif params[:task][:name].present? 
    #     @tasks = Task.search_name()
    #   elsif params[:task][:progress].present? 
    #     @tasks = Task.search_progress()
    #   else
    #   @tasks = Task.all.order(created_at: :desc)
    #   end 
    # end
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :detail, :deadline, :progress, :priority)
    end
end
