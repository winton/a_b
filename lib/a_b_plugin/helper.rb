module ABPlugin
  module Helper
    
    private
    
    def a_b(variant, &block)
      return unless ABPlugin.active?
      @a_b_selections, selected = ABPlugin.select_variant(@a_b_selections, variant)
      block.call if block_given? && selected
    end
    
    def a_b_script_tag
      return unless ABPlugin.active?
      options = {
        :selections => @a_b_selections || {},
        :session_id => ABPlugin.session_id,
        :tests => ABPlugin.tests,
        :token => Digest::SHA256.hexdigest(ABPlugin.session_id + ABPlugin.user_token),
        :url => ABPlugin.url
      }
      "<script type=\"text/javascript\">A_B.setup(#{options.to_json});</script>"
    end
  end
end