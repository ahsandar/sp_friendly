module SPFriendly
  module Exceptions
    class Base < StandardError;end
  end
end


module SPFriendly
  module Exceptions
    class EmptyRequestBodyError < ::SPFriendly::Exceptions::Base;end
  end
end


class JsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::Http::Parameters::ParseError => error
      output = "Invalid JSON : #{error}"
      return [
        400, { 'Content-Type' => 'application/json' },
        [ { status: 400, error: output }.to_json ]
      ]
    end
  end
end
