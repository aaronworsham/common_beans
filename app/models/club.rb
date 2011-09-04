class Club < ActiveRecord::Base
  belongs_to :user
  has_many  :club_memberships
  has_many  :members,
            :through => :club_memberships
end
