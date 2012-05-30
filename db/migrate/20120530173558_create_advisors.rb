class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :keycode

      t.timestamps
    end
  end
end
