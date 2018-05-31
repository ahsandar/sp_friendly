module Api
  module V1
    class SettingsController < ApplicationController

      include Request::Validation::User

      before_action :block_params, only: [:block]
      before_action :verify_blocklist_params, only: [:block]

      def block
        block_list = User.add_to_block_list(params)
        if block_list
          render_success({}, 201)
        else
            render_failure({error: "Unable to block user at the moment"})
        end
      end

      private
      def block_params
        params.permit(:requestor, :target)
      end

    end
  end
end
