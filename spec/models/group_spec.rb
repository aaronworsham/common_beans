require 'spec_helper'

describe Group do

  before(:each) do
    @founder = Factory :user
    @founder_group_portfolio = Factory :group_portfolio, :user => @founder
    @group = Group.new(@founder, @founder_group_portfolio)
  end

  after(:each) do
    $redis.flushdb
  end

  context :add_user_and_portfolio  do

    context :distruted_user do
      it 'will fail to add distruted user' do
        @portfolio_count = GroupPortfolio.count
        member = Factory :user
        portfolio = Factory :portfolio
        lambda{@group.add_user_and_portfolio(member, portfolio)}.should raise_error(GroupError::UserNotTrusted)
      end

    end

    context :trusted do
      before(:each) do
        @portfolio_count = GroupPortfolio.count
        @member = Factory :user
        @portfolio = Factory :portfolio
        @founder.trust!(@member, 5)
        @member.trust!(@founder, 5)
        @portfolio = @group.add_user_and_portfolio(@member, @portfolio)
      end

      it 'will return members' do
        @group.members.all.should == [@member]
      end

      it 'will remove member' do
        @group.members.all.should == [@member]
        @group.remove_user_and_portfolio(@member, @portfolio)
        @group.members.all.should == []
      end

      it 'will have added a member' do
        @group.member?(@member).should be_true
      end

      it 'will have a member portfolio' do
        @group.member_portfolio?(@portfolio).should be_true
      end

      it 'removes the user and portfolio' do
        @group.remove_user_and_portfolio(@member, @portfolio)
        @group.member?(@member).should be_false
        @group.member_portfolio?(@portfolio).should be_false
        GroupPortfolio.count.should == @portfolio_count
      end

      context :already_member do
        it 'will fail when already member' do
          portfolio = Factory :portfolio
          lambda{@group.add_user_and_portfolio(@member, portfolio)}.should raise_error(GroupError::UserAlreadyMember)
        end
      end

      context :already_listing_portfolio do
        it 'will fail when already member' do
          lambda{@group.send("add_member_portfolio", @portfolio)}.should raise_error(GroupError::PortfolioAlreadyListed)
        end
      end

      context :max_member_listed do
        it 'will fail with max member count' do
          lambda{
            6.times do |x|
              user = Factory :user
              @founder.trust!(user,5)
              user.trust!(@founder, 5)
              @group.send("add_member", user)
            end
          }.should raise_error(GroupError::GroupMaxMemberCount)
          @group.member_count.should == 5
        end
      end
    end

  end
end