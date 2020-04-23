# frozen_string_literal: true

require 'set'

class CoerceBoolean
  FALSE_VALUES = Set[
    nil, "",
    false, 0,
    "0", :"0",
    "f", :f,
    "F", :F,
    "false", :false,
    "FALSE", :FALSE,
    "off", :off,
    "OFF", :OFF,
  ].freeze

  def self.from(value)
    !FALSE_VALUES.include?(value)
  end
end
