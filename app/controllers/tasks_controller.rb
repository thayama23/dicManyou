class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    # ラベルでのソートの時、最初に書いた場所。
    # @tasks = Task.all

    # @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    ##########
    
    if current_user.present?
      # binding.irb
    # @tasks = Task.all.order(created_at: :desc)
    # @tasks = Task.where(user_id: current_user)
      @tasks = current_user.tasks
      
      if params[:sort_expired] == "true"  
        @tasks = @tasks.order(deadline: :ASC)

      elsif params[:sort_priority] == "true"
      @tasks = @tasks.order(priority: :DESC)
      # binding.irb

      elsif params[:task].present?
        name = params[:task][:name]
        progress = params[:task][:progress]
        @tasks = @tasks.search_name(name).search_progress(progress)
       
      elsif  params[:label_id].present?
        @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) 
  
      else
        @tasks = @tasks.all.order(created_at: :desc)
        # binding.irb
      end
      @tasks = @tasks.page(params[:page]).per(5)# = Task.new.page(params[:page]).per(10)
      # binding.irb

    else
      redirect_to new_user_path
      # binding.irb
    end

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
    @labels = @task.labels

  end

  # GET /tasks/new
  def new
    # @task = Task.new

    if current_user == nil
      redirect_to new_user_path, notice: "ログインするか新規ユーザー設定後Taskをご使用下さい。"
    else
      # User has_many Tasks だった場合
      # @task = current_user.tasks.build
      # render :new
      @task = Task.new
    end
  end
 
  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    
    # @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      # @task
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
      params.require(:task).permit(:name, :detail, :deadline, :progress, :priority, { label_ids: [] })
    end

end
