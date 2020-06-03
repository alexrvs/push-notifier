module SetUserByToken
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= User.authenticate(request.headers['access-token'])
  end
end
