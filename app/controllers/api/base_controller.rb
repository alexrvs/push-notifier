class Api::BaseController < ActionController::API
  include SetUserByToken
  include ExceptionHandler

  before_action :authenticate_user!

  protected

  def render_this(obj: nil, collection: nil, status: :ok, msg: false, meta: false)
    json = {}
    if obj
      json[:message] = msg if msg
      json[:data] = "#{obj.class}Serializer".constantize.new(obj).as_json
    else
      json[:meta] = meta if meta
      json[:data] = ActiveModel::Serializer::CollectionSerializer.new(collection)
    end
    render json: json, status: status
  end

  def render_data(data, status: :ok)
    render json: { data: data }, status: status
  end

  private

  def authenticate_user!
    raise AuthorizationError unless current_user
  end

end
