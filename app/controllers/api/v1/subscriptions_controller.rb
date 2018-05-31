module Api
  module V1
    class SubscriptionsController < ApplicationController


      include Request::Validation::Subscription

      before_action :subscription_params, only: [:create]
      before_action :verify_subscription_params, only: [:create]
      before_action :subscription_list, only: [:list]
      before_action :verify_sender_email, only:[:list]
      before_action :extract_mentions, only:[:list]


      def index
        subscriptions = Subscription.all
        render json: subscriptions
      end


      def create
        subscription = Subscription.create_subscription(params)
        if subscription[:success]
          render_success({}, 201)
        else
          render_failure({error: "Unable to create subscription at the moment"})
        end
      end


      def list
        subscription_list = Subscription.get_subscription_list(params[:sender], @mentions)
        if subscription_list[:success]
          render_success({ recipients: subscription_list[:response]})
        else
          render_failure({error: "Unable to list subscriptions at the moment"})
        end
      end


      private
      def subscription_params
        params.permit(:requestor, :target)
      end

      def subscription_list
        params.permit(:sender, :text)
      end

      def extract_mentions
        @mentions = email_regex(params[:text])
      end

    end

  end
end
