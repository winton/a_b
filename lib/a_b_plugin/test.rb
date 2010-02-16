class ABPlugin
  class Test
    
    def initialize(test)
      @test = ABPlugin.tests.detect do |t|
        t['name'] == test || symbolize_name(t['name']) == test
      end
    end
    
    def convert(name=nil, &block)
      return unless @test
      
      conversion = Cookies.get(:conversions, @test)
      visit = Cookies.get(:visits, @test)
      variant = variant(name)
      
      if conversion && variant
      # Already converted
        block.call if conversion == variant['id']
      
      elsif variant && variant['id'] == visit
      # Not yet converted
        block.call
        Cookies.set(:conversions, @test, variant)
      
      elsif name.nil? && visit
      # No variant specified and test has been visited
        block.call symbolize_name(visit['name'])
      end
      
      symbolize_name(visit['name']) if visit
    end
    
    def visit(name=nil, &block)
      return unless @test
      
      visit = Cookies.get(:visits, @test)
      variant = variant(name)
      
      if visit && variant
      # Already visited
        block.call if visit == variant
      
      elsif variant
      # Not yet visited  
        variants = test['variants'].sort do |a, b|
          a['visits'] <=> b['visits']
        end
        visit = variants.first
        if visit && visit == variant
          block.call
          variant['visits'] += 1
          Cookies.set(:visits, @test, variant)
        end
        
      elsif name.nil? && visit
      # No variant specified and test has been visited
        block.call symbolize_name(visit['name'])
      end
      
      symbolize_name(visit['name']) if visit
    end
    
    private
    
    def symbolize_name(name)
      name.downcase.gsub(/[^a-zA-Z0-9\s]/, '').gsub('_', '').intern
    end
    
    def variant(name)
      return unless name && @test
      @test['variants'].detect do |t|
        t['name'] == name || symbolize_name(t['name']) == name
      end
    end
  end
end