module ABPlugin
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
        block.call if conversion == variant
      elsif variant && variant == visit
        block.call
        Cookies.set(:conversions, variant['id'])
      elsif visit
        block.call symbolize_name(visit['name'])
      end
      symbolize_name(visit['name']) if visit
    end
    
    def symbolize_name(name)
      name.downcase.gsub(/[^a-zA-Z0-9\s]/, '').gsub('_', '').intern
    end
    
    def variant(name)
      return unless name && @test
      @test['variants'].detect do |t|
        t['name'] == name || symbolize_name(t['name']) == name
      end
    end
    
    def visit(name=nil, &block)
      return unless @test
      visit = Cookies.get(:visits, @test)
      variant = variant(name)
      if visit && variant
        block.call if visit == variant
      elsif variant
        variants = test['variants'].sort do |a, b|
          a['visits'] <=> b['visits']
        end
        visit = variants.first
        if visit && visit == variant
          block.call
          variant['visits'] += 1
          Cookies.set(:visits, variant['id'])
        end
      elsif visit
        block.call symbolize_name(visit['name'])
      end
      symbolize_name(visit['name']) if visit
    end
  end
end