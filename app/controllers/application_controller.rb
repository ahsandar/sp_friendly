class ApplicationController < ActionController::API

  include Response
  include Helper

  rescue_from TypeError, JSON::ParserError do |exception|
    render json: {error: @error_msg || "POST body must be JSON"}.to_json, status: 422
  end

  rescue_from ActionController::RoutingError do |exception|
    render json: {error: "Not Found"}.to_json, status: 404
  end

  rescue_from Exception do |exception|
    render json: {error:  @error_msg || "Internal Server Exception"}.to_json, status: @status || 500
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {error: "Not Found"}.to_json, status: 404
  end

end
