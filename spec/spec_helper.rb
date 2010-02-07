require File.expand_path("#{File.dirname(__FILE__)}/../require")
Require.spec_helper!

Spec::Runner.configure do |config|
end

def params(url)
  CGI.parse(URI.parse(url).query)
end

def stub_api_boot
  @session_id = 's'*20
  @token = 't'*20
  @url = 'http://test.com'
  @user_token = 'u'*20
  @tests = [{
    "name" => "Test",
    "variants" => [
      {
        "name" => "v1",
        "visits" => 0
      },
      {
        "name" => "v2",
        "visits" => 0
      },
      {
        "name" => "v3",
        "visits" => 0
      }
    ]
  }]
  ABPlugin::API.stub!(:boot).and_return(
    "tests" => @tests,
    "user_token" => @user_token
  )
end