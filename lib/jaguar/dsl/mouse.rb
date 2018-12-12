module Jaguar
  module DSL
    module Mouse
      def self.move(x,y)
        Jaguar.driver.do({
          device: :mouse,
          action: :move,
          params: { x: x, y: y }
        })
      end
    end
  end
end
