require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

module ABPlugin
  
  class HelperInstance
    include Helper
  end
  
  module Helper
    
    describe ABPlugin::Helper do
      
      describe :a_b do
        
        before(:each) do
          stub_api_boot
          ABPlugin.token = @token
          ABPlugin.url = @url
          ABPlugin.session_id = @session_id
          ABPlugin.reload
        end
        
        it "should call a block if variant has been selected" do
          called = false
          ABPlugin.should_receive(:select_variant).with(nil, 'v1').and_return([ {}, true ])
          ABPlugin::HelperInstance.new.send(:a_b, 'v1') do
            called = true
          end
          called.should == true
        end
        
        it "should not call a block if variant has not been selected" do
          called = false
          ABPlugin.should_receive(:select_variant).with(nil, 'v1').and_return([ {}, false ])
          ABPlugin::HelperInstance.new.send(:a_b, 'v1') do
            called = true
          end
          called.should == false
        end
      end
      
      describe :a_b_script_tag do
        
        before(:each) do
          stub_api_boot
          ABPlugin.token = @token
          ABPlugin.url = @url
          ABPlugin.session_id = @session_id
          ABPlugin.stub!(:select_variant).and_return([ { 'Test' => 'v1' }, true ])
          instance = ABPlugin::HelperInstance.new
          instance.send(:a_b, 'v1')
          js = instance.send(:a_b_script_tag)
          @setup_params = JSON[/<script.+>A_B.setup\((.+)\);<\/script>/.match(js)[1]]
        end
        
        it "should call A_B.config with the correct parameters" do
          @setup_params.should == {
            "selections" => { "Test" => "v1" },
            "session_id" => @session_id,
            "tests" => @tests,
            "token" => Digest::SHA256.hexdigest(@session_id + @user_token),
            "url" => @url
          }
        end
      end
    end
  end
end
