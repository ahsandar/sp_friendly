  module Response

    extend ActiveSupport::Concern


    def heartbeat
      response_success({})
    end

    def render_success(obj ='', status = 200)
      render json: {success: true}.merge(obj).to_json, status: status
    end

    def render_failure(obj, status = 409)
      render json: {success: false}.merge(obj).to_json, status: status
    end

  end
