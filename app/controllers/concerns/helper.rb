  module Helper

    extend ActiveSupport::Concern

    def email_regex(val)
      val.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)
    end

    def invalid_email_exception(msg = "Invalid Email")
      @error_msg = msg
      @status = 422
      raise JSON::ParserError
    end

    def verify_requestor_and_target
      invalid_email_exception('Invalid or Missing requestor') if email_regex(params[:requestor] || '').empty?
      invalid_email_exception('Invalid or Missing target') if email_regex(params[:target] || '').empty?
    end

  end
