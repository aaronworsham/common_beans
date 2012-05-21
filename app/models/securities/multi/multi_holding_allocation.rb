class MultiHoldingAllocation < ActiveRecord::Base
  belongs_to :multi_holding
  belongs_to :fund_ticker

  attr_accessible :ticker_name, :ticker_symbol


  include AASM

  aasm_column :current_state

  aasm_initial_state :active

  aasm_state :active
  aasm_state :inactive

  aasm_event :activate do
    transitions :to => :active, :from => [:inactive]
  end

  aasm_event :deactivate do
    transitions :to => :inactive, :from => [:active]
  end


end
