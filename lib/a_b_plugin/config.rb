module ABPlugin
  module Config
    class <<self
      
      def config_yaml(config_yaml=nil)
        @config_yaml = config_yaml unless config_yaml.nil?
        @config_yaml || ("#{root}/config/a_b.yml" if root)
      end
      
      def data_yaml
        @data_yaml = data_yaml unless data_yaml.nil?
        @data_yaml || ("#{root}/config/a_b_data.yml" if root)
      end
      
      def root(root=nil)
        @root = root unless root.nil?
        @root
      end
      
      def url(url=nil)
        @url = url unless url.nil?
        @url
      end
      
      def user_token(user_token=nil)
        @user_token = user_token unless user_token.nil?
        @user_token
      end
    end
  end
end