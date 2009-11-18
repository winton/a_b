module ABPlugin
  class API
    include HTTParty
    
    def initialize(token)
      @token = token
    end
    
    def boot
      self.class.get('/boot.json', :query => { :token => @token })
    end
  end
end