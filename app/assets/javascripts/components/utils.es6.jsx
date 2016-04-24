function updateTask(params, index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/update`,
    data: params,
    dataType: 'json',
    success: function(data){
      index.setState(
        {
          tasks: data.tasks,
          tags: data.tags,
          selected_task: data.selected_task,
          flash: null
        }
      );
    },
    error: function(){
      index.setState({
        flash: "Task title cannot be blank."
      });
    }
  });
}

function getSelectedTask(id, index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/select`,
    data: {task: {id: id}},
    dataType: 'json',
    success: function(data){
      index.setState({selected_task: data});
      $('.show.task.modal').modal('toggle');
    }
  });
}


function timerOn(target, start_time){
  target.timer({
    seconds: start_time,
    format: '%h hr %m min %s sec'
  });
}

function timerOff(target){
  target.timer('remove');
}

function currentDuration(task){
  if (task.started_at){
    var now = Date.now() / 1000 | 0;
    var duration = task.duration + now - task.started_at;
  }
  else{
    duration = task.duration
  }
  return {
    hr: Math.floor(duration / 3600),
    min: Math.floor(duration / 60 % 60),
    sec: Math.floor(duration % 60)
  };
}


function taskButtonAction(action, id, index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/${action}`,
    data: {task: {id: id}},
    dataType: 'json',
    success: function(data){
      index.setState(data);
    }
  });
}

function blankSafe(arg){
  return arg ? arg : <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
}