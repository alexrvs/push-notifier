module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid,  with: :invalid_record
    rescue_from CanCan::AccessDenied,         with: :access_denied
    rescue_from AuthorizationError,           with: :not_authorize
    rescue_from ValidationError,              with: :validation_error
    rescue_from MessageError,                 with: :message_error
  end

  def not_found(_exception)
    render_error 'Record not found', :not_found
  end

  def invalid_record(exception)
    render_error exception.record.errors.as_json(full_messages: true), :unprocessable_entity
  end

  def access_denied(exception)
    render json: { errors: exception.message }, status: :unauthorized
  end

  def stripe_error(exception)
    render_error({ none_field: exception.message.split(':').first }, :unprocessable_entity)
  end

  def not_authorize
    render_error I18n.t('auth.errors.messages.not_authenticate'), :unauthorized
  end

  def invalid_credentials(exception)
    render json: { errors: exception.object.as_json(full_messages: true) }, status: :unprocessable_entity
  end

  def validation_error(exception)
    render json: { errors: exception.errors.as_json(full_messages: true) }, status: :unprocessable_entity
  end

  def message_error(exception)
    errors = exception.errors.as_json(full_messages: true)
    render json: { errors: { none_field: errors } }, status: :unprocessable_entity
  end

  def information_message(exception)
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  private

  def render_error(errors, status)
    render json: { errors: errors }, status: status
  end
end