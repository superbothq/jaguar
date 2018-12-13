require "delirium"
require "contracts"

module Jaguar
  include Contracts::Core
  include Contracts::Builtin
  C = Contracts

  class Error < StandardError; end

  @@driver = Delirium::Driver.class_for_current_platform.new

  Contract nil => Delirium::Driver::Base
  def self.driver
    @@driver
  end

  Contract Delirium::Driver::Base => nil
  def self.driver=(d)
    @@driver = d
    nil
  end

  Contract Jaguar::C::Args[Any] => nil
  def self.debug(*args)
    return unless ENV["JAGUAR_DEBUG"] == "yes"

    print "JAGUAR DEBUG: "
    for arg in args
      arg_formatted = case arg
      when String
        arg
      else
        arg.inspect
      end
      print arg_formatted
      print " "
    end
    puts ""
    nil
  end
end

require_relative "jaguar/version"
require_relative "jaguar/helpers"
