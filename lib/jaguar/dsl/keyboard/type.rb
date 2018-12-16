module Jaguar
  module DSL
    module Keyboard
      module Type
        include Contracts::Core

        Contract Jaguar::C::Args[Jaguar::C::Or[Integer,String,Symbol,Array,Hash]] => self.class
        def self.type(*integer_or_string_or_symbol_or_arrays_or_hashes)
          opts, type_sequence = parse_type_args_to_opts_and_type_sequence integer_or_string_or_symbol_or_arrays_or_hashes

          sequence = unpack_type_sequence type_sequence
          delay = opts[:delay]

          Jaguar.debug "sequence", sequence, "delay", delay

          sequence.each do |s|
            already_delayed = false

            case s
            when String,Integer
              Jaguar.debug "direct_write_instead_of_key_presses?(delay)", direct_write_instead_of_key_presses?(delay)

              if direct_write_instead_of_key_presses?(delay)
                Jaguar.driver.do device: :keyboard, action: :write, params: {string: s}
              else
                s.split('').each do |k|
                  Jaguar.driver.do device: :keyboard, action: :write, params: {string: s}
                  Jaguar::Helpers.delay delay if delay
                  already_delayed = true
                end
              end
            when Array
              non_mods = s.pop
              Jaguar.debug "non_mods", non_mods
              for mod in s do
                Jaguar.driver.do device: :keyboard, action: :key_down, params: {key: mod}
              end

              case non_mods
              when String,Symbol
                # [:alt, "d"]
                # [:cmd, :tab]
                Jaguar.driver.do device: :keyboard, action: :key_press, params: {key: non_mods}
              when Array
                # [:alt, [:tab, :tab]]
                non_mods.each do |non_mod|
                  Jaguar.driver.do device: :keyboard, action: :key_press, params: {key: non_mod}
                  Jaguar::Helpers.delay delay if delay
                  already_delayed = true
                end
              end

              for mod in s do
                Jaguar.driver.do device: :keyboard, action: :key_up, params: {key: mod}
              end
            when Symbol
              Jaguar.driver.do device: :keyboard, action: :key_press, params: {key: s}
            end

            unless already_delayed
              Jaguar::Helpers.delay delay if delay
            end
          end

          self
        end

        private

        Contract Jaguar::C::Args[Jaguar::C::Or[Integer,String,Symbol,Array,Hash]] => Array[Hash,Array]
        def self.parse_type_args_to_opts_and_type_sequence(args)
          opts = {}
          type_sequence = []
          args.each do |integer_or_string_or_symbol_or_array_or_hash|
            case integer_or_string_or_symbol_or_array_or_hash.class.name
            when "Integer","String", "Array", "Symbol"
              type_sequence << integer_or_string_or_symbol_or_array_or_hash
            when "Hash"
              opts.merge!(integer_or_string_or_symbol_or_array_or_hash)
            end
          end
          [opts, type_sequence]
        end

        Contract Jaguar::C::Or[Integer,Float,Range,NilClass] => Jaguar::C::Bool
        def self.direct_write_instead_of_key_presses?(delay)
          case delay
          when Integer
            delay == 0
          when Float
            delay == 0.0
          when Range
            delay.first == 0 && delay.last == 0
          when NilClass
            true
          end
        end

        Contract Jaguar::C::Or[String,Array,Symbol] => Array
        def self.unpack_type_sequence(type_sequence)
          case type_sequence
          when String
            # type "hello"
            type_sequence.split ''
          when Array
            # type "hello", :enter
            # type [:ctrl, :c]
            # type [:alt, [:tab, :tab]]
            type_sequence
          when Symbol
            # type :enter
            [type_sequence]
          end
        end
      end
    end
  end
end
