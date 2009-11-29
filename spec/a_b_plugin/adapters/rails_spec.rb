require File.expand_path("#{File.dirname(__FILE__)}/../../spec_helper")

describe ABPlugin::Adapters::Rails do

  include Rack::Test::Methods

  def app
    ActionController::Dispatcher.new
  end

  it "home page" do
    get "/"
    last_response.ok?.should == true
  end
end