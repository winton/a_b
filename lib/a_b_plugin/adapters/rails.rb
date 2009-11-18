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
        ABPlugin.session_id = session.session_id
      end
    end
  end
end

ActionController::Base.send(:include, ABRails::Adapters::Rails)
ActionController::Base.send(:include, ABRails::Helper)
ActionController::Base.helper(ABRails::Helper)