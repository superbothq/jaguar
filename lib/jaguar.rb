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
end

require_relative "jaguar/version"
