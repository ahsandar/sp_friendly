class Subscription < ApplicationRecord
  belongs_to :requestor, class_name: 'User'
  belongs_to :target, class_name: 'User'

  validates :requestor_id, presence: true
  validates :target_id, presence: true


  def self.create_subscription(emails)
      user_ids = User.create_users([emails[:requestor], emails[:target]])
      response_obj(true, self.find_or_create_by(requestor_id:user_ids.first, target_id:user_ids.last))
  end

  def self.get_subscription_list(email, mentions)
    user_list = User.get_subscription_list(email)
    response_obj(true, (user_list + mentions).uniq)
  end


end
