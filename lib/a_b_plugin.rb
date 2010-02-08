require File.expand_path("#{File.dirname(__FILE__)}/../require")
Require.lib!

require File.dirname(__FILE__) + "/a_b_plugin/adapters/rails" if defined?(Rails)
require File.dirname(__FILE__) + "/a_b_plugin/adapters/sinatra" if defined?(Sinatra)

module ABPlugin
  class <<self
    
    attr_accessor :cached_at
    attr_accessor :session_id
    attr_accessor :tests
    
    def boot(config=nil, data=nil)
      yaml = Yaml.new(config || Config.config_yaml)
      boot = yaml.boot
      if boot
        File.open(data || Config.data_yaml, 'w') do |f|
          f.write(boot.to_yaml)
        end
      end
    end
    
    def generate_token
      letters_and_numbers = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      token = ""
      20.times do
        token << letters_and_numbers[rand(letters_and_numbers.size-1)]
      end
      token
    end
    
    def reload
      @cached_at = Time.now
      
      config = Yaml.new(Config.config_yaml)
      data = Yaml.new(Config.data_yaml)
      
      @tests = data['tests']
      @user_token = data['user_token']
      @url = config['url']
      
      unless @tests && @user_token && @url
        @@cached_at = Time.now - 9 * 60 # Try again in 1 minute
      end
    end
    
    def reload?
      @@cached_at.nil? || (Time.now - @@cached_at).to_i >= 10 * 60
    end
  end
end