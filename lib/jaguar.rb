require "delirium"

module Jaguar
  class Error < StandardError; end
  def self.driver
    @@driver ||= Delirium::Driver.class_for_current_platform.new
  end
  def self.driver=(d)
    @@driver = d
  end
end

require_relative "jaguar/version"
