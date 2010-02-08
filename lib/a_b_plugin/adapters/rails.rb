module ABPlugin
  module Adapters
    module Rails
    
      def self.included(klass)
        if defined?(::ApplicationController)
          raise 'Please require a_b_plugin before all other plugins.'
        end
        klass.before_filter :a_b_plugin_before_filter
      end
    
      private
      
      def a_b_plugin_before_filter
        ABPlugin.generate_token
        ABPlugin::Cookies.cookies = request.cookies
        ABPlugin::Config.root = Rails.root
        ABPlugin.reload if ABPlugin.reload?
      end
    end
  end
end

ActionController::Base.send(:include, ABPlugin::Adapters::Rails)
ActionController::Base.send(:include, ABPlugin::Helper)
ActionController::Base.helper(ABPlugin::Helper)