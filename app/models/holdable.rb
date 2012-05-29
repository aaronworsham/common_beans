module Holdable
  def self.included( target )
    target.class_eval {
      after_update :populate_points
      after_update do |x|
        x.portfolio.populate_points
      end
    }
  end
end