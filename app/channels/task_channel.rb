class TaskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "task_channel"
    stream_from "task_channel_#{current_user}"
    data = {
      type: "tasks",
      payload: Task.all
    }
    ActionCable.server.broadcast("task_channel_#{current_user}", data)
  end

  def add_task(params)
    @task = Task.new({ description: params['description'], nickname: current_user, status: "To Do" })

    if @task.save
      payload = @task
    end

    data = {
      type: "task",
      operation: "add",
      payload: payload,
    }

    ActionCable.server.broadcast("task_channel", data)
  end

  def save_task(params)
    task = Task.find_by(id: params['_id'])

    if task.update(status: params['status'])
      payload = task
    end

    data = {
      type: "task",
      operation: "update",
      payload: payload,
    }

    ActionCable.server.broadcast("task_channel", data)
  end

  def delete_task(params)
    task = Task.find_by(id: params['_id'])

    if task.destroy
      data = {
        type: "task",
        operation: "delete",
        payload: params['_id'],
      }
      ActionCable.server.broadcast("task_channel", data)
    end
  end

end