class FinancialAdvice < ActiveRecord::Base
  set_table_name 'financial_advice'
  belongs_to :financial_client, :class_name => 'User', :primary_key => 'id', :foreign_key => 'user_id'
  belongs_to :financial_adviser, :class_name => 'User'
end
