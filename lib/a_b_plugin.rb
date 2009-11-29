require File.dirname(__FILE__) + "/a_b_plugin/core_ext/array"
require File.dirname(__FILE__) + "/a_b_plugin/core_ext/module"
require File.dirname(__FILE__) + "/a_b_plugin/api"
require File.dirname(__FILE__) + "/a_b_plugin/helper"
require File.dirname(__FILE__) + "/a_b_plugin/adapters/rails" if defined?(Rails)
require File.dirname(__FILE__) + "/a_b_plugin/adapters/sinatra" if defined?(Sinatra)

module ABPlugin
  
  mattr_accessor :cached_at
  mattr_accessor :session_id
  mattr_accessor :tests
  mattr_accessor :token
  mattr_accessor :url
  mattr_accessor :user_token
  
  class <<self
    
    def active?
      @@cached_at && @@session_id && @@tests && @@token && @@url && @@user_token
    end
    
    def reload
      begin
        boot = ABPlugin::API.boot @@token, @@url
        @@cached_at = Time.now
        @@tests = boot['tests']
        @@user_token = boot['user_token']
      rescue Exception => e
        @@cached_at = Time.now - 50 * 60 # Try again in 10 minutes
        @@tests = nil
        @@user_token = nil
      end
    end
    
    def reload?
      @@cached_at.nil? || (Time.now - @@cached_at).to_i >= 60 * 60
    end
  
    def select_variant(selections, variant)
      return [ selections, false ] unless active?
      selections ||= {}
      test = test_from_variant(variant)
      return [ selections, false ] unless test
      if !selections[test['name']]
        variants = test['variants'].sort do |a, b|
          a['visits'] <=> b['visits']
        end
        variants.first['visits'] += 1
        selections[test['name']] = variants.first['name']
      end
      [ selections, selections[test['name']] == variant ]
    end
  
    def test_from_variant(variant)
      return nil unless @@tests
      tests = @@tests.select do |t|
        t['variants'].collect { |v| v['name'] }.include?(variant)
      end
      tests.first
    end
  end
end