class EOD
    POINTS = {
          "d7"   => 7.days.ago,
         "d30"  => 30.days.ago,
         "d180" => 180.days.ago,
         "d365" => 1.year.ago,
         "y2"   => 2.years.ago,
         "y3"   => 3.years.ago,
         "y4"   => 4.years.ago,
         "y5"   => 5.years.ago
    }

  def self.points
    POINTS
  end

  def self.point_names
    POINTS.keys
  end

  def self.point_dates
    POINTS.values
  end
end