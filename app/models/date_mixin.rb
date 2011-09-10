module DateMixin
  def seconds_to_days(sec)
    (sec / 86400).round
  end

  def seconds_to_years(sec)
    (sec).divmod( 31536000)
  end

  def humanize_seconds(sec)
    if sec > 31536000
      year, sec = seconds_to_years(sec)
      "Year #{year} Day #{seconds_to_days(sec)}"
    else
      "Day #{seconds_to_days(sec)}"
    end
  end
end
