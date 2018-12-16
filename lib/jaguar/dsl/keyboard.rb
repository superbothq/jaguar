module Jaguar
  module DSL
    module Keyboard
      include Contracts::Core

      Contract Jaguar::C::Args[Jaguar::C::Or[Integer,String,Symbol,Array,Hash]] => self.class
      def self.type(*integer_or_string_or_symbol_or_array_or_hashes)
        Type.type *integer_or_string_or_symbol_or_array_or_hashes
        self
      end
    end
  end
end

require_relative "keyboard/type"
