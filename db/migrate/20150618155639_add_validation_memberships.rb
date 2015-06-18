class AddValidationMemberships < ActiveRecord::Migration
  def up
    change_column :memberships, :user_id, :integer, null: false
    change_column :memberships, :meetup_id, :integer, null: false
  end
  def down
    change_column :memberships, :user_id, :integer
    change_column :memberships, :meetup_id, :integer
  end
end
