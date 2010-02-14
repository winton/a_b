module ABPlugin
  module Adapters
    module Sinatra
    
      def self.included(klass)
        ABPlugin::Config.root = Rails.root
      end
    end
  end
end

Sinatra::Base.send(:include, ABPlugin::Adapters::Sinatra)
Sinatra::Base.send(:include, ABPlugin::Helper)