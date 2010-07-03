require 'rubygems'
require 'bundler'

Bundler.require(:spec)

SPEC = File.dirname(__FILE__)

require SPEC + '/fixtures/rails/config/environment'
require SPEC + '/fixtures/sinatra'

require "#{Bundler.root}/lib/a_b_plugin"
require 'pp'

require "#{Bundler.root}/rails/init"

Spec::Runner.configure do |config|
  include ABPlugin::Helper
end

# For use with rspec textmate bundle
def debug(object)
  puts "<pre>"
  puts object.pretty_inspect.gsub('<', '&lt;').gsub('>', '&gt;')
  puts "</pre>"
end

def setup_variables
  @tests = [{
    "id" => 1,
    "name" => "Test",
    "variants" => [
      {
        "id" => 2,
        "name" => "v1",
        "visits" => 0
      },
      {
        "id" => 3,
        "name" => "v2",
        "visits" => 0
      },
      {
        "id" => 4,
        "name" => "v3",
        "visits" => 0
      }
    ]
  }]
end

def stub_api_boot
  setup_variables
  ABPlugin::API.stub!(:boot).and_return(
    "tests" => @tests
  )
end