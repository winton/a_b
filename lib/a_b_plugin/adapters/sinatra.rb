module ABPlugin
  module Adapters
    module Sinatra
    
      def self.included(klass)
        klass.send :before do
          ABPlugin.session_id = env["rack.request.cookie_hash"]["rack.session"][0..19]
        end
        
        # TODO: After filter to re-request boot.json every hour
      end
    end
  end
end

Sinatra::Base.send(:include, ABPlugin::Adapters::Sinatra)
Sinatra::Base.send(:include, ABPlugin::Helper)