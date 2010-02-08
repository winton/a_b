module ABPlugin
  module Helper
    
    private
    
    def a_b(test=nil)
      ABPlugin.active?
      if test
        Test.new(test)
      elsif ABPlugin.session_id && ABPlugin.tests && Config.url && Config.user_token
        options = {
          :session_id => ABPlugin.session_id,
          :tests => ABPlugin.tests,
          :token => Digest::SHA256.hexdigest(ABPlugin.session_id + ABPlugin.user_token),
          :url => ABPlugin.url
        }
        "<script type='text/javascript'>A_B.setup(#{options.to_json});</script>"
      end
    end
  end
end