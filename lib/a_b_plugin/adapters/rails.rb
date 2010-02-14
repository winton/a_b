module ABPlugin
  module Adapters
    module Rails
    
      def self.included(klass)
        ABPlugin::Config.root = Rails.root
      end
    end
  end
end

ActionController::Base.send(:include, ABPlugin::Adapters::Rails)
ActionController::Base.send(:include, ABPlugin::Helper)
ActionController::Base.helper(ABPlugin::Helper)