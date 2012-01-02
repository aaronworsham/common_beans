require 'spec_helper'

describe Message do

  before(:each) do
    pending('Not quite working yet')
  end

  after(:each) do
    $redis.flushdb
  end

  it 'will raise an error with less than all the options' do
    lambda{Message.new({})}.should raise_error(MessageError::MissingParams)
  end


  context :everyone do
    before(:each) do
      @message = MessageEveryone.new(
        :text => 'text',
        :action => 'action',
        :user => (Factory :user)
      )
    end
    context :saving do
      before(:each) do
       @message.save.should > 0
      end

      it 'should save' do
        MessageEveryone.reader.count.should == 1
      end

      it 'should return one entry' do
        MessageEveryone.reader.last_entry.should == @message.to_json
      end

      it 'should be parsable' do
        JSON.parse(MessageEveryone.reader.last_entry)['text'].should == 'text'
      end

      it 'should have a sequence of 1' do
        JSON.parse(MessageEveryone.reader.last_entry)['sequence'].should == 1
      end

      context :more_than_one do
        before(:each) do
          $redis.flushdb
          10.times do |x|
            MessageEveryone.new(
              :text => x.to_s,
              :action => 'action',
              :user => (Factory :user)
            ).save
          end
        end
        it 'should have 10 messages in the queue' do
          MessageEveryone.reader.count.should == 10
          JSON.parse(MessageEveryone.reader.last_entry)['text'].should == '9'
        end

        it 'should support reading the queue' do
          MessageEveryone.reader.read.size.should == 10
        end

        it 'last message should have sequence 10' do
          JSON.parse(MessageEveryone.reader.last_entry)['sequence'].should == 10
        end

      end
    end
  end



  context :friend do

    it 'should raise error for missing friend id' do
      lambda{
        MessageFriend.new(
          :text => 'text',
          :action => 'action',
          :user => (Factory :user)
        )
      }.should raise_error(MessageError::MissingParams)
    end

    it 'should raise error for untrusted user' do
      lambda{
        friend = Factory :user
        MessageFriend.new(
          :text => 'text',
          :action => 'action',
          :user => (Factory :user),
          :friend => friend
        )
      }.should raise_error(MessageError::UserNotTrusted)
    end

    it 'user should be able to message a friend' do
      friend = Factory :user
      user = Factory :user
      user.trust!(friend, 5)
      friend.trust!(user, 5)
      user.create_friend_message(friend,'test')
      friend.friend_reader.count.should == 1
    end

    context :saving do
      before(:each) do
        @friend = Factory :user
        @user = Factory :user
        @user.trust!(@friend, 5)
        @friend.trust!(@user, 5)
        @message = MessageFriend.new(
          :text => 'text',
          :action => 'action',
          :user => @user,
          :friend => @friend
        )
        @message.save.should > 0
      end

      it 'should save' do
        @message.reader.count.should == 1
      end

      it 'should return one entry' do
        @message.reader.last_entry.should == @message.to_json
      end

      it 'should be parsable' do
        JSON.parse(@message.reader.last_entry)['text'].should == 'text'
      end

      it 'should have a sequence of 1' do
        JSON.parse(@message.reader.last_entry)['sequence'].should == 1
      end

      context :more_than_one do
        before(:each) do
          $redis.flushdb
          @user.trust!(@friend, 5)
          @friend.trust!(@user, 5)
          10.times do |x|
            MessageFriend.new(
              :text => x.to_s,
              :action => 'action',
              :user => @user,
              :friend => @friend
            ).save
          end
        end
        it 'should have 10 messages in the queue' do
          @friend.friend_reader.count.should == 10
          JSON.parse(@friend.friend_reader.last_entry)['text'].should == '9'
        end

        it 'should support reading the queue' do
          @friend.friend_reader.read.size.should == 10
        end

        it 'should have a sequence of 10' do
          JSON.parse(@friend.friend_reader.last_entry)['sequence'].should == 10
        end
      end
    end


  end

  context :group do

    it 'should raise error for missing friend id' do
      lambda{
        MessageGroup.new(
          :text => 'text',
          :action => 'action',
          :user => (Factory :user)
        )
      }.should raise_error(MessageError::MissingParams)
    end

    it 'should be able to send a message to the group' do
      gp = Factory :group_portfolio
      gp.create_group_message('test')
      gp.group_reader.count.should == 1
    end

    it 'user should have group messages' do
      gp = Factory :group_portfolio
      user = gp.user
      gp.create_group_message('test')
      gp.group_reader.count.should  == 1
      user.group_messages[0]['text'].should == 'test'
    end

    context :saving do
      before(:each) do
        @group = Factory :share_group
        @message = MessageGroup.new(
          :text => 'text',
          :action => 'action',
          :user => (Factory :user),
          :group => @group
        )
        @message.save.should > 0
      end

      it 'should save' do
        @message.reader.count.should == 1
      end

      it 'should return one entry' do
        @message.reader.last_entry.should == @message.to_json
      end

      it 'should be parsable' do
        JSON.parse(@message.reader.last_entry)['text'].should == 'text'
      end

      it 'should have sequence of 1' do
        JSON.parse(@message.reader.last_entry)['sequence'].should == 1
      end

      context :more_than_one do
        before(:each) do
          $redis.flushdb
          10.times do |x|
            MessageGroup.new(
              :text => x.to_s,
              :action => 'action',
              :user => (Factory :user),
              :group => @group
            ).save
          end
        end
        it 'should have 10 messages in the queue' do
          @group.group_reader.count.should == 10
          JSON.parse(@group.group_reader.last_entry)['text'].should == '9'
        end

        it 'should support reading the queue' do
          @group.group_reader.read.size.should == 10
        end

        it 'should have sequence of 1' do
          JSON.parse(@group.group_reader.last_entry)['sequence'].should == 10
        end
      end
    end
  end

end