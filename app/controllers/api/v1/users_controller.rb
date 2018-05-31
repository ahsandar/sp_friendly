module Api
  module V1
    class UsersController < ApplicationController

      def index
        @users = User.all

        render json: @users
      end


      def block_list
        @block_list = BlockList.all

        render json: @block_list
      end

    end
  end
end
