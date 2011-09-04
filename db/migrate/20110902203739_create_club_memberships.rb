class CreateClubMemberships < ActiveRecord::Migration
  def change
    create_table :club_memberships do |t|
      t.integer :club_id
      t.integer :user_id

      t.timestamps
    end
  end
end
