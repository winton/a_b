require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe AB::Adapters::Rails do

  include Rack::Test::Methods

  def app
    ActionController::Dispatcher.new
  end
  
  it "should set AB::Config.env" do
    AB::Config.env.should == 'development'
  end
  
  it "should set AB::Config.root" do
    AB::Config.root.to_s.include?('spec/fixtures/rails').should == true
  end
  
  [ :controller, :helper ].each do |type|
    
    describe type do
      it "should respond to a_b" do
        get "/#{type}/respond_to/a_b"
        last_response.body.should == '1'
      end

      it "should not respond to this_should_fail" do
        get "/#{type}/respond_to/this_should_fail"
        last_response.body.should == '0'
      end
    end
  end
end