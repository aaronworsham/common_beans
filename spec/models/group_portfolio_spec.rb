require 'spec_helper'

describe GroupPortfolio do
  before(:each) do
    @compare_group = Factory :compare_group
    @share_group = Factory :share_group
  end

  after(:each) do
    $redis.flushdb
  end

  it 'should have a group' do
    @compare_group.group.should be
    @share_group.group.should be
  end

  it 'should have a founder' do
    @compare_group.founder.should be
    @share_group.founder.should be
  end

  it 'should allow adding self to group' do
    @compare_group.group.member_count.should == 0
    @compare_group.add_self
    @compare_group.group.member_count.should == 1
  end

  context :activate do
    before(:each) do
      @member_portfolio = Factory :group_portfolio
    end
    it 'should be a lead group portfolio' do
      @compare_group.lead?.should be_true
      @share_group.lead?.should be_true
    end

    it 'should be a active as lead group portfolios' do
      @compare_group.active?.should be_true
      @share_group.active?.should be_true
    end

    it 'is a member group portfolio' do
      @member_portfolio.is_member?.should be_true
    end

    it 'member should be in pending state' do
      @member_portfolio.pending?.should be_true
    end

    it 'member can be activated' do
      @member_portfolio.activate!.should be_true
      @member_portfolio.active?.should be_true
    end

  end



  context :adding_user do
    before(:each) do
      @user = Factory :user
    end
    it 'should fail to add an untrusted member' do
      lambda{@compare_group.add_member(@user)}.should raise_error(GroupError::UserNotTrusted)
    end

    it 'should add a trusted user' do
      @compare_group.group.member_count.should == 0
      @compare_group.group.portfolio_count.should == 0
      @compare_group.user.trust!(@user, 5)
      @user.trust!(@compare_group.user, 5)
      @compare_group.add_member(@user)
      @compare_group.group.member_count.should == 1
      @compare_group.group.portfolio_count.should == 1
    end
  end

  context :remove_user do
    before(:each) do
      @user = Factory :user
    end

    it 'should add a trusted user' do
      @compare_group.group.member_count.should == 0
      @compare_group.group.portfolio_count.should == 0
      @compare_group.user.trust!(@user, 5)
      @user.trust!(@compare_group.user, 5)
      @compare_group.add_member(@user)
      portfolio = @user.group_portfolios.find_by_founder_group_id(@compare_group)
      portfolio.should be
      @compare_group.group.member_count.should == 1
      @compare_group.group.portfolio_count.should == 1
      @compare_group.remove_member(@user, portfolio)
      @compare_group.group.member_count.should == 0
      @compare_group.group.portfolio_count.should == 0
    end
  end


  context :compare do
    it 'should be a compare group' do
      @compare_group.compare_group?
    end
    context :users do
      before(:each) do
        @members = []
        4.times do
          member = Factory :user
          @members << member
          @compare_group.user.trust!(member,5)
          member.trust!(@compare_group.user, 5)
          @compare_group.add_member(member)
        end
      end

      it 'will say that the user has a group portfolio' do
        @members.each do |u|
          u.group_portfolios.size.should == 1
          u.group_portfolios.find_by_founder_group_id(@compare_group.id).should be
        end
      end

      it 'all member portfolios will be pending' do
        @members.each do |u|
          u.group_portfolios.find_by_founder_group_id(@compare_group.id).pending?.should be_true
        end
      end
    end
  end

  context :share do
    it 'should be a compare group' do
      @share_group.share_group?
    end
  end


end
