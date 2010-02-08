module ABPlugin
  class Yaml
    
    attr_reader :path
    attr_reader :yaml
    
    def initialize(path)
      env = ENV['RACK_ENV'] || ENV['RAILS_ENV']
      @path = path
      @yaml = YAML::load(File.open(@path)) if @path
      @yaml = yaml[env] if @yaml && @yaml[env]
    end
    
    def boot
      if self['token'] && self['url']
        API.boot self['token'], self['url']
      end
    end
    
    def dirname
      if @path
        File.dirname(@path)
      end
    end
    
    def method_missing(method, *args)
      if @yaml
        @yaml.send method, *args
      else
        nil
      end
    end
  end
end