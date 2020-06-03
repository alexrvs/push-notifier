class Api::V1::Users::SessionsController < Devise::SessionsController
  include ExceptionHandler

  def create
    resource = User.find_for_database_authentication(email: params[:email])
    raise MessageError, I18n.t('auth.sessions.bad_credentials') unless resource

    if resource.valid_password?(params[:password])
      append_new_token_to!(resource)
      obj = { data: ActiveModelSerializers::SerializableResource.new(resource).serializable_hash }
      obj[:data][:access_token] = resource.authentication_token
      render json: obj, status: 200
    else
      raise MessageError, I18n.t('auth.sessions.bad_credentials')
    end
  end

  private

  def append_new_token_to!(resource)
    resource.append_new_token
    resource.save
  end
end
