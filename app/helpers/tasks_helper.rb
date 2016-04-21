module TasksHelper

  def incomplete_tasks
    current_user.tasks.where(completed_at: nil)
  end

  def complete_tasks
    current_user.tasks.where.not(completed_at: nil)
  end

  def tasks_hash
    {
        incomplete: incomplete_tasks.map{|task| react_task(task)},
        complete: complete_tasks.map{|task| react_task(task)}
    }
  end

  def react_task(task)
    json = task.as_json
    json['started_at'] = json['started_at'] ? json['started_at'].to_i : nil
    json['completed_at'] = json['completed_at'] ? json['completed_at'].to_i : nil
    json['duration_display'] = duration_display(task.duration)
    if task.tag
      json['tag'] = {'id' => task.tag.id, 'name' => task.tag.name}
    end
    json
  end

  def duration_display(duration)
    return 'Not started' unless duration
    duration_string = "#{duration % 60} sec"
    duration_string.prepend '0' unless duration < 60 or duration % 60 > 9
    duration_string.prepend "#{duration / 60 % 60} min "
    duration_string.prepend '0' unless duration < 3600 or duration / 60 % 60 > 9
    duration_string.prepend "#{duration / 3600} hr "
  end

end
