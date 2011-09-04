class Group < ActiveRecord::Base
  belongs_to :user
  has_many :group_memberships
  has_many :members,
           :through => :group_memberships

end
