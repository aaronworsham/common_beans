module TrackersHelper
  def trust_level_select
    {
      "1 - Public: Anyone can see safe version"    => 1,
      "2 - Private: 'Colleagues' can see safe version plus 'Friends, Family and Advisors'"   => 2,
      "3 - Private: 'Friends' can see safe version plus 'Family and Advisors'"   => 3,
      "4 - Private: 'Family' can see safe version plus 'Advisors'"   => 4,
      "5 - Personal: Only you and your financial Advisor can see"   => 5,
    }
  end
end
