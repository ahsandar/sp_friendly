  module Request
    module Validation
      module Subscription

        extend ActiveSupport::Concern

        def verify_subscription_params
          verify_requestor_and_target
        end

        def verify_sender_email
          invalid_email_exception('Invalid or Missing sender') if email_regex(params[:sender] || '').empty?
        end

      end
    end
  end
