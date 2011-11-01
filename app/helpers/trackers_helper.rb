module TrackersHelper
  def min_trust_level_select
    {
      "1 - Public can see safe version"    => 1,
      "2 - Private, friends can see safe version"   => 2,
      "3 - Private, friends with TRUST level 3 and above can see safe version"   => 3,
      "4 - Private, friends with TRUST level 4 and above can see safe version"   => 4,
      "5 - Private, friends with TRUST level 5 and above can see safe version"   => 5,
      "6 - Private, friends with TRUST level 6 and above can see safe version"   => 6,
      "7 - Private, friends with TRUST level 7 and above can see safe version"   => 7,
      "8 - Private, friends with TRUST level 8 and above can see safe version"   => 8,
      "9 - Private, friends with TRUST level 9 can see safe version"   => 9,
      "10 - Personal, only you and your financial advisor can see this version"   => 10,
    }
  end
end
