class Point

  NAMES =
    [
      "d7"    ,
      "d30"   ,
      "d180"  ,
      "d365"  ,
      "y2"    ,
      "y3"    ,
      "y4"    ,
      "y5"
    ]

  def self.names
    NAMES
  end

  def self.dates(date = Date.today)
   {
      "d7"   => (date - 7.days),
      "d30"  => (date - 30.days),
      "d180" => (date - 180.days),
      "d365" => (date - 1.year),
      "y2"   => (date - 2.years),
      "y3"   => (date - 3.years),
      "y4"   => (date - 4.years),
      "y5"   => (date - 5.years)
    }
  end

  def self.date(name, start_date = Date.today)
    self.dates(start_date)[name]
  end


end