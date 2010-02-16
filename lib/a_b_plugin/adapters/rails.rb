class ABPlugin
  module Adapters
    module Rails
    
      def self.included(klass)
        ABPlugin::Config.env = Rails.env
        ABPlugin::Config.root = Rails.root
        klass.after_filter { ABPlugin.reset }
      end
    end
  end
end

ActionController::Base.send(:include, ABPlugin::Adapters::Rails)
ActionController::Base.send(:include, ABPlugin::Helper)
ActionController::Base.helper(ABPlugin::Helper)