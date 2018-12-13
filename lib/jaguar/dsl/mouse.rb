module Jaguar
  module DSL
    module Mouse
      include Contracts::Core

      Contract Jaguar::C::KeywordArgs[
        x: Integer, y: Integer
      ] => self.class
      def self.move(x:nil, y:nil)
        Jaguar.driver.do({
          device: :mouse,
          action: :move,
          params: { x: x, y: y }
        })
        self
      end

      Contract Integer, Integer => self.class
      def self.move(x,y)
        move x:x, y:y
      end
    end
  end
end
