class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  include ExceptionHandler

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
