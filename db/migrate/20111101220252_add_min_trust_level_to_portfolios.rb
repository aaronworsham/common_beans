class AddMinTrustLevelToPortfolios < ActiveRecord::Migration
  def change
    add_column    :portfolios,    :min_trust_level,  :integer
  end
end
