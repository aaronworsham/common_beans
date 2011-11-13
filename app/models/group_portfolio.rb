class GroupPortfolio < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :portfolio
  belongs_to  :founder_group,
              :class_name => 'GroupPortfolio'


  def founder
    founder_group.user
  end

  def founder_portfolio
    if member_portfolio?
      founder_group.portfolio
    else
      portfolio
    end
  end

  def member_portfolio?
    founder_group.present?
  end

  def lead_portfolio?
    founder_group.empty?
  end

end
