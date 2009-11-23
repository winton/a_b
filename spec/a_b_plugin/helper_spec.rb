require File.dirname(__FILE__) + '/../spec_helper'

module ABPlugin
  
  class HelperInstance
    include Helper
  end
  
  module Helper
    
    describe ABPlugin::Helper do
      
      describe :a_b do
        
        it "should call a block if variant has been selected" do
          called = false
          ABPlugin.should_receive(:select_variant).with(nil, 'v1').and_return([ {}, true ])
          HelperInstance.new.send(:a_b, 'v1') do
            called = true
          end
          called.should == true
        end
        
        it "should not call a block if variant has not been selected" do
          called = false
          ABPlugin.should_receive(:select_variant).with(nil, 'v1').and_return([ {}, false ])
          HelperInstance.new.send(:a_b, 'v1') do
            called = true
          end
          called.should == false
        end
      end
      
      describe :a_b_script_tag do
        
        before(:each) do
          stub_api_boot
          ABPlugin.config @token, @url
          ABPlugin.session_id = @session_id
          ABPlugin.stub!(:select_variant).and_return([ { 'Test' => 'v1' }, true ])
          instance = HelperInstance.new
          instance.send(:a_b, 'v1')
          js = instance.send(:a_b_script_tag)
          @increment_params = params(/src="([^"]+)"/.match(js)[1])
          @setup_params = JSON[/<script.+>A_B.setup\((.+)\);<\/script>/.match(js)[1]]
        end
        
        it "should call increment.js with a session_id" do
          @increment_params['session_id'][0].should == @session_id
        end
        
        it "should call increment.js with a token" do
          @increment_params['token'][0].should == Digest::SHA256.hexdigest(@session_id + @user_token)
        end
        
        it "should call increment.js with a list of visited variants" do
          @increment_params['visits[]'][0].should == 'v1'
        end
        
        it "should call A_B.config with the correct parameters" do
          @setup_params.should == {
            "token" => Digest::SHA256.hexdigest(@session_id + @user_token),
            "tests" => @tests,
            "session_id" => @session_id,
            "url" => @url,
            "visits" => { "Test" => "v1" }
          }
        end
      end
    end
  end
end
