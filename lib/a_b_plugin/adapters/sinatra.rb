module ABPlugin
  module Adapters
    module Sinatra
    
      def self.included(klass)
        klass.send :after do
          ABPlugin.reload if ABPlugin.reload?
        end
        
        klass.send :before do
          session_id = env["rack.request.cookie_hash"]["rack.session"][0..19] rescue nil
          ABPlugin.session_id = session_id
        end
      end
    end
  end
end

Sinatra::Base.send(:include, ABPlugin::Adapters::Sinatra)
Sinatra::Base.send(:include, ABPlugin::Helper)