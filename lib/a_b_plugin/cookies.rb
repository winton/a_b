class ABPlugin
  module Cookies
    class <<self
      
      def get(type, test)
        return unless type && test
        
        type = type.to_s[0..0]
        
        Cookie.new[type][test['id']]
      end
      
      def set(type, test, variant)
        return unless type && test && variant
        
        type = type.to_s[0..0]
        
        cookie = Cookie.new
        cookie[type][test['id']] = variant['id']
        cookie.sync
      end
      
      class Cookie < Hash
        
        def initialize
          return unless ABPlugin.instance
          
          cookie = ABPlugin.instance.cookies[:a_b]
          self.replace(JSON cookie) if cookie
          
          self['c'] ||= {}
          self['v'] ||= {}
        end
        
        def sync
          return unless ABPlugin.instance
          ABPlugin.instance.cookies[:a_b] = self.to_json
          true
        end
      end
    end
  end
end