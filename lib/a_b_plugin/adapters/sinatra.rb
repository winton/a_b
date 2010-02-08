module ABPlugin
  module Adapters
    module Sinatra
    
      def self.included(klass)
        klass.send :before do
          ABPlugin.generate_token
          ABPlugin::Cookies.cookies = request.cookies
          ABPlugin::Config.root = Rails.root
          ABPlugin.reload if ABPlugin.reload?
        end
      end
    end
  end
end

Sinatra::Base.send(:include, ABPlugin::Adapters::Sinatra)
Sinatra::Base.send(:include, ABPlugin::Helper)