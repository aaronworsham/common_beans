class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string  :addressable_type
      t.integer :addressable_id
      t.string  :address_1
      t.string  :address_2
      t.string  :address_state
      t.string  :address_city
      t.string  :address_zip
      t.string  :address_country
      t.string  :phone
      t.string  :fax
      t.string  :mail_address_1
      t.string  :mail_address_2
      t.string  :mail_address_state
      t.string  :mail_address_city
      t.string  :mail_address_zip
      t.string  :mail_address_country
      t.string  :url
      t.string  :email
      t.timestamps
    end
  end
end
