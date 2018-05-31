  module Request
    module Validation
      module Friendship

        extend ActiveSupport::Concern

        def verify_friend_list
          friends = params[:friends]

          unless friends.is_a? Array
            @error_msg = "friends need to be an Array"
            @status = 422
            raise JSON::ParserError
          else
            invalid_email_exception('friends array requires 2 email Ids only') if friends.size != 2
            friends.each do |friend|
              verify_user_email(friend)
            end
          end
        end

        def verify_user_email(email = nil)
          invalid_email_exception if email_regex(email || params[:email]).empty?
        end

      end
    end
  end
