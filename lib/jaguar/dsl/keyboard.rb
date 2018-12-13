module Jaguar
  module DSL
    module Keyboard
      include Contracts::Core

      Contract Jaguar::C::Args[Jaguar::C::Or[String,Array,Symbol,Hash]] => self.class
      def self.type(*string_or_arrays_or_symbol_or_hashes)
        Type.type *string_or_arrays_or_symbol_or_hashes
        self
      end
    end
  end
end

require_relative "keyboard/type"
