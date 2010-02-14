module ABPlugin
  module Helper
    
    private
    
    def a_b(test=nil)
      @a_b_plugin ||= ABPlugin.new(self)
      if test
        Test.new(test)
      elsif ABPlugin.tests && Config.url
        options = {
          :tests => ABPlugin.tests,
          :url => Config.url
        }
        "<script type='text/javascript'>A_B.setup(#{options.to_json});</script>"
      end
    end
  end
end