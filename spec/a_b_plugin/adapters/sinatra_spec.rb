require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe ABPlugin::Adapters::Sinatra do

  include Rack::Test::Methods

  def app
    SinatraApp.new
  end
  
  [ :controller, :helper ].each do |type|
    
    describe type do
      it "should respond to a_b" do
        get "/#{type}/respond_to/a_b"
        last_response.body.should == '1'
      end

      it "should respond to a_b_script_tag" do
        get "/#{type}/respond_to/a_b_script_tag"
        last_response.body.should == '1'
      end

      it "should not respond to sanity_check_failure" do
        get "/#{type}/respond_to/sanity_check_failure"
        last_response.body.should == '0'
      end
      
      it "should set the session id before every request" do
        ABPlugin.should_receive(:session_id=).with(nil)
        get "/#{type}/respond_to/a_b"
      end
      
      it "should try to reload after every request" do
        ABPlugin.should_receive(:reload?).and_return(true)
        ABPlugin.should_receive(:reload)
        get "/#{type}/respond_to/a_b"
      end
    end
  end
end