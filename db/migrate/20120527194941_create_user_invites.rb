class CreateUserInvites < ActiveRecord::Migration
  def change
    create_table :user_invites do |t|
      t.string  :name
      t.string  :token
      t.string  :email
      t.string  :passcode
      t.string  :salt
      t.timestamps
    end
  end
end
