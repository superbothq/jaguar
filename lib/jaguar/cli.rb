require_relative "../jaguar" # if required only "jaguar/cli"
require_relative "dsl"
require "pry"

module Jaguar
  module CLI
    class RootCommand
      include Contracts::Core

      Contract ({ eval_string: Jaguar::C::Maybe[String] }) => nil
      def self.run(eval_string:nil)
        TOPLEVEL_BINDING.eval """
          include Jaguar::DSL
        """
        if eval_string
          TOPLEVEL_BINDING.eval eval_string
        else
          TOPLEVEL_BINDING.eval "Pry.start"
        end
        nil
      end
    end
  end
end

