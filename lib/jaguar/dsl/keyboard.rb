module Jaguar
  module DSL
    module Keyboard
      include Contracts::Core

      Contract Jaguar::C::Args[Jaguar::C::Or[String,Array,Symbol,Hash]] => self.class
      def self.type(*string_or_arrays_or_symbol_or_hashes)
        opts = {}
        sequence = []
        string_or_arrays_or_symbol_or_hashes.each do |string_or_array_or_symbol_or_hash|
          case string_or_array_or_symbol_or_hash.class.name
          when "String", "Array", "Symbol"
            sequence << string_or_array_or_symbol_or_hash
          when "Hash"
            opts.merge!(string_or_array_or_symbol_or_hash)
          end
        end

        params = { sequence: sequence }.merge(opts)
        Jaguar.driver.do({
          device: :keyboard,
          action: :type,
          params: params
        })
        self
      end
    end
  end
end
