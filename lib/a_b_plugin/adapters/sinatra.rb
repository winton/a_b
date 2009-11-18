module ABPlugin
  module Adapters
    module Sinatra
    
      def self.included(klass)
        klass.send :before do
          ABPlugin.session_id = env['rack.session.options']['_session_id']
        end
      end
    end
  end
end

Sinatra::Base.send(:include, ABPlugin::Adapters::Sinatra)
Sinatra::Base.send(:include, ABPlugin::Helper)