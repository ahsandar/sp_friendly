class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :requestor_id
      t.integer :target_id
      t.timestamps
    end
  end
end
