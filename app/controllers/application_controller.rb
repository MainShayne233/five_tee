class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :authenticate_user!

  def get_task
    if params[:task] and params[:task][:id]
      @task = current_user.tasks.find(params[:task][:id])
    else
      @task = current_user.tasks.new
    end
  end

  def call_coffeescript(path)
    respond_to do |format|
      format.js {render path}
    end
  end

  def reset_flash
    flash[:success] = nil
  end

  def get_sorted_tasks
    @incomplete_tasks = current_user.incomplete_tasks.where(archive_id: nil)
    @completed_tasks = current_user.completed_tasks.where(archive_id: nil)
  end

  def update_duration_if_running!(task)
    if task.running?
      task.pause!
      task.start!(current_user)
    end
  end

  def react_json
    respond_to do |format|
      format.json { render json: react_payload}
    end
  end

end
