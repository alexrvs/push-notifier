require 'fcm'
class AndroidNotifierWorker
  include Sidekiq::Worker

  def perform(notification)
    connection = establish_connection
    registration_ids = current_user.devices.map(&:uuid)
    options = { "notification": {"body": notification.message}}
    connection.send(registration_ids, options)
  end

  private

  def establish_connection
    FCM.new("path/to/my_server_key")
  end

end