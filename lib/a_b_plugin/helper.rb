module ABPlugin
  module Helper
    
    private
    
    def a_b(variant, &block)
      block.call if block_given? && ABPlugin.select_variant?(@a_b_selections, variant)
    end
    
    def a_b_script_tag
      token = Digest::SHA256.hexdigest(ABPlugin.session_id + ABPlugin.user_token)
      options = { :session_id => ABPlugin.session_id, :token => token, :url => ABPlugin.url }
      variants = (@a_b_selections || {}).values.collect { |v| "variants[]=#{v}" }.join '&'
      url = ABPlugin.url + "/visit.js?session_id=#{ABPlugin.session_id}&token=#{token}&#{variants}"
      [ "<script src=\"#{url}\" type=\"text/javascript\"></script>",
        "<script type=\"text/javascript\">A_B.setup(#{options.to_json});</script>"
      ].join
    end
  end
end