class Friendship < ApplicationRecord
    belongs_to :person, class_name: 'User'
    belongs_to :friend, class_name: 'User'

    validates :person_id, presence: true
    validates :friend_id, presence: true

    def self.create_friends(emails)
        user_ids = User.create_users(emails)
        if BlockList.check(user_ids[0], user_ids[1])
          return response_obj(true, self.find_or_create_by(person_id:user_ids[0], friend_id:user_ids[1]))
        else
          return response_obj(false, "User #{emails[0]} has blocked #{emails[1]}")
        end
    end

    def self.get_friend_list(email)
      response_obj(true, User.get_friend_list(email))
    end

    def self.common_friends(emails)
      friends = []
      emails.each do |email|
        friends << User.get_friend_list(email)
      end
      response_obj(true, friends.flatten.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first))
    end



end
