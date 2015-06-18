class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :name, null: false, unique: true
      t.string :description, null: false
      t.string :location, null: false
      t.belongs_to :user
    end
  end
end
