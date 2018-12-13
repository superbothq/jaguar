module Jaguar
  module Helpers
    include Contracts::Core
    Contract Jaguar::C::Or[Range,Integer,Float] => self.class
    def self.delay(d=0.0..0.0)
      case d
      when Range
        sleep rand(d) # gotta love ruby
      when Integer, Float
        sleep d
      end
      self
    end
  end
end
