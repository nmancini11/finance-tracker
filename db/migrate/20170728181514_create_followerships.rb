class CreateFollowerships < ActiveRecord::Migration
  def change
    create_table :followerships do |t|
      t.belongs_to :user
      t.belongs_to :follower, class: 'User'
      t.timestamps
    end
  end
end
