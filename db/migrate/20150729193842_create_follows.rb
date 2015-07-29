class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower_id, index: true
      t.integer :followed_id, index: true

      t.timestamps null: false
    end
  add_index :follows, [ :follower_id, :followed_id ], unique: true
  end
end
