class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  include ExceptionHandler

  def_param_group :user do
    param :user, Hash, :required => true, :action_aware => true do
      param :email, String, "Email of the new user"
      param :password, String, "Password of the new user"
    end
  end
  api :POST, "/v1/users/sign_up", "Create new user"
  param_group :user

  returns :code => :unprocessable_entity, :desc => "User wasn't created" do
    param_group :user
  end

  def create
    resource = build_resource(resource_params)
    if resource.save
      render json: { data: { email: resource.email } }, status: 201
    else
      warden.custom_failure!
      raise ValidationError, resource.errors
    end
  end

  protected

  def resource_params
    params.permit(:email, :password)
  end
end
