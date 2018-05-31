module Api
  module V1
    class FriendshipsController < ApplicationController

      include Request::Validation::Friendship

      before_action :friendship_params, only: [:create]
      before_action :verify_friend_list, only: [:create, :common]
      before_action :user_email, only: [:list]
      before_action :verify_user_email, only: [:list]


      def index
        friendships = Friendship.all
        render json: friendships
      end


      def list
        friendship_list = Friendship.get_friend_list(params[:email])
        if friendship_list[:success]
          render_success({firends: friendship_list[:response], count: friendship_list[:response].count})
        else
          render_failure({error: "Unable to list friends for #{user_email}"})
        end
      end


      def common
          common_friendship = Friendship.common_friends(params[:friends])
          if common_friendship[:success]
            render_success({firends: common_friendship[:response], count: common_friendship[:response].count})
          else
            render_failure({error: "Unable to list friends for #{user_email}"})
          end
      end

      def create
        friendship = Friendship.create_friends(params[:friends])
        if friendship[:success]
          render_success({},201)
        else
          render_failure({error: friendship[:response]})
        end
      end


      private
      def friendship_params
        params.permit(:friends)
      end

      def user_email
        params.permit(:email)
      end

    end
  end
end
