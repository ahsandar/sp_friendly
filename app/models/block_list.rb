class BlockList < ApplicationRecord
  belongs_to :blocker, class_name: 'User'
  belongs_to :blockee, class_name: 'User'

  validates :blocker_id, presence: true
  validates :blockee_id, presence: true


  def self.add_to_block_list(user_ids)
    self.find_or_create_by(blocker_id: user_ids.first, blockee_id: user_ids.last)
  end

  def self.check(blocker, blockee)
    self.where(blocker_id: blocker, blockee_id: blockee)
  end

end
