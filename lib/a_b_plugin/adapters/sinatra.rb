module ABPlugin
  module Adapters
    module Sinatra
    
      def self.included(klass)
        klass.send :after do
          ABPlugin.reload if ABPlugin.reload?
        end
        
        klass.send :before do
          ABPlugin.session_id = env["rack.request.cookie_hash"]["rack.session"][0..19]
        end
      end
    end
  end
end

Sinatra::Base.send(:include, ABPlugin::Adapters::Sinatra)
Sinatra::Base.send(:include, ABPlugin::Helper)