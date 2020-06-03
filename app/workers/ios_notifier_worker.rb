class IosNotifierWorker
  include Sidekiq::Worker

  def perform(notification)
    connection = establish_connection
    connection.open
    connection.write(notification.message)
    connection.close
  end

  private

  def establish_connection
    certificate = File.read("/path/to/apple_push_notification.pem")
    Houston::Connection.new(Houston::APPLE_PRODUCTION_GATEWAY_URI, certificate, 'test')
  end

end