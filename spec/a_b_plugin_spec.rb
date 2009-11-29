require File.dirname(__FILE__) + '/spec_helper'

$time_now = Time.now

module ABPlugin
  describe ABPlugin do
    
    before(:each) do
      stub_api_boot
      Time.stub!(:now).and_return($time_now)
    end
    
    describe :config do
      
      it "should retrieve API data" do
        API.should_receive(:boot).with(@token, @url)
        ABPlugin.token = @token
        ABPlugin.url = @url
        ABPlugin.session_id = @session_id
        ABPlugin.reload
      end
    
      it "should update class variables" do
        ABPlugin.token = @token
        ABPlugin.url = @url
        ABPlugin.cached_at.should == $time_now
        ABPlugin.tests.should == @tests
        ABPlugin.token.should == @token
        ABPlugin.url.should == @url
        ABPlugin.user_token.should == @user_token
      end
    end
    
    describe :reload? do
      
      it "should return true if an hour has passed since last load" do
        ABPlugin.token = @token
        ABPlugin.url = @url
        ABPlugin.reload?.should == false
        Time.stub!(:now).and_return($time_now + 60 * 60 - 1)
        ABPlugin.reload?.should == false
        Time.stub!(:now).and_return($time_now + 60 * 60)
        ABPlugin.reload?.should == true
      end
    end
    
    describe :select_variant do
      
      before(:each) do
        @selections = { 'Test' => 'v1' }
        @variant = 'v1'
        ABPlugin.token = @token
        ABPlugin.url = @url
      end
      
      it "should receive a hash of previous selections and the variant to attempt to select" do
        ABPlugin.should_receive(:select_variant).with(@selections, @variant)
        ABPlugin.select_variant @selections, @variant
      end
      
      it "should return the updated selections and a boolean describing if the variant was chosen" do
        ABPlugin.select_variant(@selections, @variant).should == [ @selections, true ]
      end
      
      it "should return the selections and false if test name not present" do
        ABPlugin.select_variant(@selections, 'Fail').should == [ @selections, false ]
      end
      
      it "should pick a selection based on least number of visits if a selection does not exist" do
        ABPlugin.tests.first['variants'][0]['visits'] = 0
        ABPlugin.tests.first['variants'][1]['visits'] = 1
        ABPlugin.tests.first['variants'][2]['visits'] = 1
        ABPlugin.select_variant({}, @variant).should == [ @selections, true ]
        
        ABPlugin.tests.first['variants'][0]['visits'] = 1
        ABPlugin.tests.first['variants'][1]['visits'] = 0
        ABPlugin.tests.first['variants'][2]['visits'] = 1
        ABPlugin.select_variant({}, @variant).should == [ { 'Test' => 'v2' }, false ]
        
        ABPlugin.tests.first['variants'][0]['visits'] = 1
        ABPlugin.tests.first['variants'][1]['visits'] = 1
        ABPlugin.tests.first['variants'][2]['visits'] = 0
        ABPlugin.select_variant({}, @variant).should == [ { 'Test' => 'v3' }, false ]
      end
    end
    
    describe :test_from_variant do
      
      before(:each) do
        ABPlugin.token = @token
        ABPlugin.url = @url
        ABPlugin.reload
      end
      
      it 'should return a test from a variant name' do
        ABPlugin.test_from_variant('v1').should == @tests.first
        ABPlugin.test_from_variant('v2').should == @tests.first
        ABPlugin.test_from_variant('v3').should == @tests.first
      end
      
      it 'should return nil if no match' do
        ABPlugin.test_from_variant('fail').should == nil
      end
    end
  end
end