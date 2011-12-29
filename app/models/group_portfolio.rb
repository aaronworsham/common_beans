class GroupPortfolio < ActiveRecord::Base

  include AASM

  belongs_to  :user
  belongs_to  :portfolio
  belongs_to  :founder_group,
              :class_name => 'GroupPortfolio'


  delegate :members,:member_count,:member_portfolios, :to => :group

  aasm_column :current_state

  aasm_initial_state :pending

  aasm_state :pending
  aasm_state :active

  aasm_event :activate do
    transitions :to => :active, :from => [:pending]
  end


  validates_presence_of :founder_group_id, :on => :create, :unless => Proc.new {|gp| gp.lead?}
  validates_presence_of :user_id
  validates_presence_of :portfolio_id

  after_create do |gp|
    gp.activate! if self.pending? and self.lead?
  end

  def is_member?
    !lead?
  end

  def founder
    if self.lead?
      self.user
    else
      self.founder_group.user
    end
  end

  def founder_portfolio
    if self.lead?
      self.portfolio
    else
      self.founder_group.portfolio
    end
  end

  def group
    if lead?
      Group.new(user, self)
    else
      Group.new(user, founder_group)
    end
  end

  def add_self
    self.group.add_user_and_portfolio(self.user, self)
  end

  def add_member(user)
    portfolio = self.class.create(
      :user => user,
      :founder_group => self
    )
    self.group.add_user_and_portfolio(user, portfolio)
  end

  def remove_self
    self.group.remove_user_and_portfolio(self.user, self.portfolio)
  end

  def remove_member(user, portfolio)
    self.group.remove_user_and_portfolio(user, portfolio)
  end

  def group_reader
    MessageGroup.reader(self.founder_portfolio.id)
  end

  def group_messages
    group_reader.read(20)
  end


  def create_group_message(txt)
    MessageGroup.new(
      :text => txt,
      :action => 'test',
      :user => self.user,
      :group => self.founder_portfolio
    ).save
  end

end
