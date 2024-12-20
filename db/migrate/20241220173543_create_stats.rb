class CreateStats < ActiveRecord::Migration[8.0]
  def change
    create_table :stats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :anime, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :current_ep, null: false, default: 0
      t.integer :rewatch_times, null: false, default: 0

      t.timestamps
    end
  end
end
