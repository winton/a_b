class ABPlugin
  class API
    
    include HTTParty
    
    def self.categories
      return unless Config.site && Config.token && Config.url
      base_uri Config.url
      get('/categories.json', :query => {
        :site => Config.site,
        :token => Config.token
      })
    end
    
    def self.create_user(attributes)
      return unless Config.token && Config.url
      base_uri Config.url
      post('/users/create.json', :query => {
        :token => Config.token,
        :user => attributes
      })
    end
  end
end