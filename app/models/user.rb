class User < ApplicationRecord

  #Friendship
  has_many :active_persons, class_name: 'Friendship', foreign_key: 'person_id', dependent: :destroy
  has_many :active_friends, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  has_many :friends, through: :active_persons, source: :friend
  has_many :persons, through: :active_friends, source: :person

  #Subscription
  has_many :active_requestors, class_name: 'Subscription', foreign_key: 'requestor_id', dependent: :destroy
  has_many :active_targets, class_name: 'Subscription', foreign_key: 'target_id', dependent: :destroy

  has_many :targets, through: :active_requestors, source: :target
  has_many :requestors, through: :active_targets, source: :requestor

  #BlockList
  has_many :active_blockers, class_name: 'BlockList', foreign_key: 'blocker_id', dependent: :destroy
  has_many :active_blockees, class_name: 'BlockList', foreign_key: 'blockee_id', dependent: :destroy

  has_many :blockees, through: :active_blockers, source: :blockee
  has_many :blockers, through: :active_blockees, source: :blocker


  def self.create_users(users)
    user_ids = []
    users.each do |user|
      user_ids << self.find_or_create_by(email: user).id
    end
    user_ids
  end

  def self.get_friend_list(email)
    list_users(email) do |user, email|
      persons = user.persons.collect{|usr| usr.email}
      friends = user.friends.collect{|usr| usr.email}
      [persons, friends].flatten.uniq
    end
  end

  def self.get_subscription_list(email)
    list_users(email) do |user, email|
      friend_list = self.get_friend_list(email)
      target = user.targets.collect{|usr| usr.email}
      blockee = user.blockees.collect{|usr| usr.email}
      [friend_list, target].flatten.uniq - blockee
    end
  end

  def self.add_to_block_list(emails)
    user_ids = self.create_users([emails[:requestor], emails[:target]])
    BlockList.add_to_block_list(user_ids)
  end

private

  def self.list_users(email, &block)
    user = self.find_by_email(email)
    user ? block.call(user, email) : []
  end

end
