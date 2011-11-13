class GroupError
  class UserAlreadyMember < StandardError
  end
  class UserNotTrusted < StandardError
  end
  class PortfolioAlreadyListed < StandardError
  end
  class GroupMaxMemberCount < StandardError
  end
end