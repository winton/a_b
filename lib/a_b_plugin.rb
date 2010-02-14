require File.expand_path("#{File.dirname(__FILE__)}/../require")
Require.lib!

require File.dirname(__FILE__) + "/a_b_plugin/adapters/rails" if defined?(Rails)
require File.dirname(__FILE__) + "/a_b_plugin/adapters/sinatra" if defined?(Sinatra)

module ABPlugin
  
  def initialize(instance=nil)
    ABPlugin.instance = instance
    
    if Config.binary
      ABPlugin.write_yaml
    elsif ABPlugin.load_yaml?
      ABPlugin.load_yaml
    end
  end
  
  class <<self
    
    attr_accessor :cached_at
    attr_accessor :tests
    
    def load_yaml?
      if @cached_at
        seconds_cached = (Time.now - @cached_at).to_i
        seconds_cached >= 10 * 60
      else
        true
      end
    end
    
    def load_yaml
      @cached_at = Time.now
      
      config = Yaml.new(Config.api_yaml)
      data = Yaml.new(Config.cache_yaml)
      
      @tests = data['tests']
      Config.token = config['token']
      Config.url = config['url']
      
      unless @tests && Config.token && Config.url
        @cached_at = Time.now - 9 * 60 # Try again in 1 minute
      end
    end
    
    def write_yaml
      yaml = Yaml.new(Config.api_yaml)
      boot = yaml.boot
      if boot
        File.open(Config.cache_yaml, 'w') do |f|
          f.write(boot.to_yaml)
        end
      end
    end
  end
end