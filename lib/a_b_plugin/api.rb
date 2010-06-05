class ABPlugin
  class API
    
    include HTTParty
    
    def self.site(options)
      return unless Config.token && Config.url && (options[:name] || Config.site)
      base_uri Config.url
      get('/site.json', :query => {
        :include => options[:include],
        :name => options[:name] || Config.site,
        :only => options[:only],
        :token => Config.token
      })
    end
  end
end