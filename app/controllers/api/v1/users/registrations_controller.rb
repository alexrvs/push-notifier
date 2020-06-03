class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  include Concerns::Api::V1::ExceptionHandler

  def create
    resource = build_resource(resource_params.merge(accepted_terms_at: Time.now))
    if resource.save
      render json: { data: { email: resource.email, name: resource.name } }, status: 201
    else
      warden.custom_failure!
      raise ValidationError, resource.errors
    end
  end

  protected

  def resource_params
    params.permit(:email, :password, :name, :terms)
  end
end
