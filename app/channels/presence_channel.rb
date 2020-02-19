class PresenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "presence_channel"
  end

  def receive(data)
    ActionCable.server.broadcast("presence_channel", data)
  end
end