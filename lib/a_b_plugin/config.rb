module ABPlugin
  module Config
    class <<self
      
      def api_yaml(api_yaml=nil)
        @api_yaml = api_yaml unless api_yaml.nil?
        @api_yaml || ("#{root}/config/a_b/api.yml" if root)
      end
      
      def binary(binary=nil)
        @binary = binary unless binary.nil?
        @binary
      end
      
      def cache_yaml
        @cache_yaml = cache_yaml unless cache_yaml.nil?
        @cache_yaml || ("#{root}/config/a_b/cache.yml" if root)
      end
      
      def root(root=nil)
        @root = root unless root.nil?
        @root
      end
      
      def url(url=nil)
        @url = url unless url.nil?
        @url
      end
      
      def token(token=nil)
        @token = token unless token.nil?
        @token
      end
    end
  end
end