module ABPlugin
  module Adapters
    module Rails
    
      def self.included(klass)
        if defined?(::ApplicationController)
          raise 'Please require a_b_plugin before all other plugins.'
        end
        klass.prepend_before_filter :a_b_plugin_before_filter
      end
    
      private
    
      def a_b_plugin_before_filter
        session_id = self.request.env["rack.request.cookie_hash"]["rack.session"][0..19] rescue nil
        if session_id
          ABPlugin.session_id = session_id
        end
      end
    end
  end
end

ActionController::Base.send(:include, ABPlugin::Adapters::Rails)
ActionController::Base.send(:include, ABPlugin::Helper)
ActionController::Base.helper(ABPlugin::Helper)