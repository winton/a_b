require File.dirname(__FILE__) + "/a_b_plugin/core_ext/array"
require File.dirname(__FILE__) + "/a_b_plugin/core_ext/module"
require File.dirname(__FILE__) + "/a_b_plugin/api"
require File.dirname(__FILE__) + "/a_b_plugin/helper"
require File.dirname(__FILE__) + "/a_b_plugin/adapters/rails" if defined?(Rails)
require File.dirname(__FILE__) + "/a_b_plugin/adapters/sinatra" if defined?(Sinatra)

module ABPlugin
  
  mattr_accessor :api
  mattr_accessor :session_id
  mattr_accessor :tests
  mattr_accessor :token
  mattr_accessor :url
  mattr_accessor :user_token
  
  class <<self
    
    def config(token, url)
      API.base_uri @@url
      @@api = API.new token
      boot = @@api.boot
      @@tests = boot['tests']
      @@token = token
      @@url = url
      @@user_token = boot['user_token']
    end
  
    def select_variant?(selections, variant)
      test = test_from_variant(variant)
      return false unless test
      if !selections || !selections[test['name']]
        variants = test['variants'].sort do |a, b|
          a['visitors'] <=> b['visitors']
        end
        variants.first['visitors'] += 1
        selections[test['name']] = variants.first['name']
      end
      selections[test['name']] == variant
    end
  
    def test_from_variant(variant)
      return nil unless ABPlugin.tests
      tests = ABPlugin.tests.select do |t|
        t['variants'].collect { |v| v['name'] }.include?(variant)
      end
      tests.first
    end
  end
end