# frozen_string_literal: true

require 'set'
require_relative './object'

class CoerceBoolean
  FALSE_VALUES = Set[
    false, 0,
    "0", :"0",
    "f", :f,
    "F", :F,
    "false", :false,
    "FALSE", :FALSE,
    "off", :off,
    "OFF", :OFF,
  ].freeze

  class << self
    def from(value, strict: false)
      value = value.to_boolean if value.respond_to? :to_boolean

      strict ? !!coerce(value) : coerce(value)
    end

    private
      def empty?(value)
        value.nil? || (value == "")
      end

      def coerce(value)
        if empty?(value)
          nil
        else
          !FALSE_VALUES.include?(value)
        end
      end
  end
end
