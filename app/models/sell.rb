class Sell< ActiveRecord::Base 

  include DateMixin
  belongs_to :user
  belongs_to :holding
  belongs_to :ticker

  validates_presence_of :holding
  validates_presence_of :user
  validates_presence_of :shares
  validates_presence_of :price
  validates_presence_of :date_of_event

  before_create :populate_return
  after_create :update_holding, :notify_everyone

  def notify_everyone
    MessageEveryone.new(
      :text     => standard_message,
      :action   => 'sold',
      :user     => user.screename
    ).save
  end

  def standard_message
    "some shares of #{ticker.symbol} at #{self.price} per share"
  end

  def action_word
    "sold"
  end

  def populate_return
    self.return_on_investment = self.shares * self.price
  end

  def update_holding
    self.holding.update_net_values_for_sell(self)
  end

  def return_on_investment
    self.shares * self.price
  end

  def investment
    0
  end

  def days_since_holding_purchase
    humanize_seconds(date_of_event - self.holding.date_of_purchase) 
  end
  def as_json(options={})
    result = super(options)
    result["action"] = self.class.name
    result["action_letter"] = self.action_word[0].capitalize
    result["investment"] = 0
    result
  end
end
