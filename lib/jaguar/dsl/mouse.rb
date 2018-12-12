module Jaguar
  module DSL
    module Mouse
      include Contracts::Core
      Contract Jaguar::C::Num, Jaguar::C::Num => self.class
      def self.move(x,y)
        Jaguar.driver.do({
          device: :mouse,
          action: :move,
          params: { x: x, y: y }
        })
        self
      end
    end
  end
end
