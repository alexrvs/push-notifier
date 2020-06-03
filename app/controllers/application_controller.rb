class ApplicationController < ActionController::API

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

end
