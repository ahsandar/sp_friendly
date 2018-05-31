  module Request
    module Validation
      module User

        extend ActiveSupport::Concern

        def verify_blocklist_params
          verify_requestor_and_target
        end

      end
    end
  end
