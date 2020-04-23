require 'test_environment'

class CoerceBooleanTest < ActiveSupport::TestCase
  test ".from returns true, false, or nil when not in strict mode" do
    # explicitly check for true vs truthy
    assert_equal true, CoerceBoolean.from(true)
    assert_equal true, CoerceBoolean.from(1)
    assert_equal true, CoerceBoolean.from("1")
    assert_equal true, CoerceBoolean.from("0.0")
    assert_equal true, CoerceBoolean.from(0.to_f)
    assert_equal true, CoerceBoolean.from(0.to_d)
    assert_equal true, CoerceBoolean.from("t")
    assert_equal true, CoerceBoolean.from("T")
    assert_equal true, CoerceBoolean.from("true")
    assert_equal true, CoerceBoolean.from("TRUE")
    assert_equal true, CoerceBoolean.from("on")
    assert_equal true, CoerceBoolean.from("ON")
    assert_equal true, CoerceBoolean.from(" ")
    assert_equal true, CoerceBoolean.from("\u3000\r\n")
    assert_equal true, CoerceBoolean.from("\u0000")
    assert_equal true, CoerceBoolean.from("SOMETHING RANDOM")
    assert_equal true, CoerceBoolean.from(:"1")
    assert_equal true, CoerceBoolean.from(:t)
    assert_equal true, CoerceBoolean.from(:T)
    assert_equal true, CoerceBoolean.from(:true)
    assert_equal true, CoerceBoolean.from(:TRUE)
    assert_equal true, CoerceBoolean.from(:on)
    assert_equal true, CoerceBoolean.from(:ON)
    assert_equal true, CoerceBoolean.from(Class)

    # explicitly check for false vs nil
    assert_predicate CoerceBoolean.from(""), :nil?
    refute_equal false, CoerceBoolean.from("")
    assert_predicate CoerceBoolean.from(nil), :nil?
    refute_equal false, CoerceBoolean.from(nil)
    assert_equal false, CoerceBoolean.from(false)
    assert_equal false, CoerceBoolean.from(0)
    assert_equal false, CoerceBoolean.from("0")
    assert_equal false, CoerceBoolean.from("f")
    assert_equal false, CoerceBoolean.from("F")
    assert_equal false, CoerceBoolean.from("false")
    assert_equal false, CoerceBoolean.from("FALSE")
    assert_equal false, CoerceBoolean.from("off")
    assert_equal false, CoerceBoolean.from("OFF")
    assert_equal false, CoerceBoolean.from(:"0")
    assert_equal false, CoerceBoolean.from(:f)
    assert_equal false, CoerceBoolean.from(:F)
    assert_equal false, CoerceBoolean.from(:false)
    assert_equal false, CoerceBoolean.from(:FALSE)
    assert_equal false, CoerceBoolean.from(:off)
    assert_equal false, CoerceBoolean.from(:OFF)
  end

  test ".from returns true or false when in strict mode" do
    # explicitly check for true vs truthy
    assert_equal true, CoerceBoolean.from(true, strict: true)
    assert_equal true, CoerceBoolean.from(1, strict: true)
    assert_equal true, CoerceBoolean.from("1", strict: true)
    assert_equal true, CoerceBoolean.from("0.0", strict: true)
    assert_equal true, CoerceBoolean.from(0.to_f, strict: true)
    assert_equal true, CoerceBoolean.from(0.to_d, strict: true)
    assert_equal true, CoerceBoolean.from("t", strict: true)
    assert_equal true, CoerceBoolean.from("T", strict: true)
    assert_equal true, CoerceBoolean.from("true", strict: true)
    assert_equal true, CoerceBoolean.from("TRUE", strict: true)
    assert_equal true, CoerceBoolean.from("on", strict: true)
    assert_equal true, CoerceBoolean.from("ON", strict: true)
    assert_equal true, CoerceBoolean.from(" ", strict: true)
    assert_equal true, CoerceBoolean.from("\u3000\r\n", strict: true)
    assert_equal true, CoerceBoolean.from("\u0000", strict: true)
    assert_equal true, CoerceBoolean.from("SOMETHING RANDOM", strict: true)
    assert_equal true, CoerceBoolean.from(:"1", strict: true)
    assert_equal true, CoerceBoolean.from(:t, strict: true)
    assert_equal true, CoerceBoolean.from(:T, strict: true)
    assert_equal true, CoerceBoolean.from(:true, strict: true)
    assert_equal true, CoerceBoolean.from(:TRUE, strict: true)
    assert_equal true, CoerceBoolean.from(:on, strict: true)
    assert_equal true, CoerceBoolean.from(:ON, strict: true)

    # explicitly check for false vs nil
    refute_predicate CoerceBoolean.from("", strict: true), :nil?
    assert_equal false, CoerceBoolean.from("", strict: true)
    refute_predicate CoerceBoolean.from(nil, strict: true), :nil?
    assert_equal false, CoerceBoolean.from(nil, strict: true)
    assert_equal false, CoerceBoolean.from(false, strict: true)
    assert_equal false, CoerceBoolean.from(0, strict: true)
    assert_equal false, CoerceBoolean.from("0", strict: true)
    assert_equal false, CoerceBoolean.from("f", strict: true)
    assert_equal false, CoerceBoolean.from("F", strict: true)
    assert_equal false, CoerceBoolean.from("false", strict: true)
    assert_equal false, CoerceBoolean.from("FALSE", strict: true)
    assert_equal false, CoerceBoolean.from("off", strict: true)
    assert_equal false, CoerceBoolean.from("OFF", strict: true)
    assert_equal false, CoerceBoolean.from(:"0", strict: true)
    assert_equal false, CoerceBoolean.from(:f, strict: true)
    assert_equal false, CoerceBoolean.from(:F, strict: true)
    assert_equal false, CoerceBoolean.from(:false, strict: true)
    assert_equal false, CoerceBoolean.from(:FALSE, strict: true)
    assert_equal false, CoerceBoolean.from(:off, strict: true)
    assert_equal false, CoerceBoolean.from(:OFF, strict: true)
  end

  test ".from calls `to_boolean` on the given object if it responds" do
    class SampleError < StandardError; end
    class SampleClass
      def self.to_boolean
        false
      end

      def to_boolean
        raise SampleError.new("to_boolean called")
      end
    end

    err = assert_raises(SampleError) { CoerceBoolean.from(SampleClass.new) }
    assert_equal "to_boolean called", err.message
    assert_equal false, CoerceBoolean.from(SampleClass)
  end
end
