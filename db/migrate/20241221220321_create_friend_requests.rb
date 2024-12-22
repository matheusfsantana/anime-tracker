class CreateFriendRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :friend_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :target_user, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
