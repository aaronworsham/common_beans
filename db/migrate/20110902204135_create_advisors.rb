class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|
      t.string :crd_num
      t.string :sec_num
      t.string :name
      t.string :legal_name
      t.string :address1
      t.string :address2
      t.string :address_city
      t.string :address_state
      t.string :address_postal
      t.string :phone
      t.string :fax
      t.string :url
      t.string :reg_status
      t.datetime :reg_date

      t.timestamps
    end
  end
end
