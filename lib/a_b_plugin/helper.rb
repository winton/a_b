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
      token = Digest::SHA256.hexdigest(ABPlugin.session_id + ABPlugin.user_token)
      visits = @a_b_selections || {}
      options = {
        :session_id => ABPlugin.session_id,
        :tests => ABPlugin.tests,
        :token => token,
        :url => ABPlugin.url,
        :visits => visits
      }
      visits = visits.values.collect { |v| "visits[]=#{v}" }.join '&'
      url = ABPlugin.url + "/increment.js?session_id=#{ABPlugin.session_id}&token=#{token}&#{visits}"
      [ "<script src=\"#{url}\" type=\"text/javascript\"></script>",
        "<script type=\"text/javascript\">A_B.setup(#{options.to_json});</script>"
      ].join
    end
  end
end