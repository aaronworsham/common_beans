class Buy< Event
  include DateMixin

  belongs_to :user
  belongs_to :holding
  belongs_to :ticker

  validates_presence_of :holding
  validates_presence_of :user
  validates_presence_of :shares
  validates_presence_of :price
  validates_presence_of :date_of_event


  before_create :populate_investment
  after_create :update_holding, :notify_everyone
  after_destroy :reset_holding

  def notify_everyone
    MessageEveryone.new(
      :text     => standard_message,
      :action     => 'bought',
      :user     => self.user
    ).save
  end

  def standard_message
    " some shares of #{ticker.yahoo_link} at #{self.price} per share"
  end

  def action_word
    "bought"
  end

  def populate_investment
    self.investment = (self.shares * self.price)
  end

  def update_holding
    self.holding.update_net_values_for_buy(self)
  end

  def reset_holding
    self.holding.reset_values_for_buy(self)
  end

  def investment
    self.shares * self.price
  end

  def return_on_investment
    0
  end
  def days_since_holding_purchase
    humanize_seconds(date_of_event - self.holding.date_of_purchase)
  end
  def as_json(options={})
    result = super(options)
    result["action"] = self.class.name
    result["action_letter"] = self.action_word[0].capitalize
    result["return_on_investment"] = 0
    result["relative_day"] = days_since_holding_purchase
    result
  end

  
end
