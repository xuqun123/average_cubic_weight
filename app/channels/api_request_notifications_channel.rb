class ApiRequestNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "api_request_notifications_channel"
  end

  def unsubscribed
  end
end