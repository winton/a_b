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
        
      end
    end
  end
end
