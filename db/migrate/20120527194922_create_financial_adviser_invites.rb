class CreateFinancialAdviserInvites < ActiveRecord::Migration
  def change
    create_table :financial_adviser_invites do |t|
      t.integer :user_id
      t.string  :token
      t.string  :email
      t.string  :passcode
      t.string  :salt
      t.timestamps
    end
  end
end
