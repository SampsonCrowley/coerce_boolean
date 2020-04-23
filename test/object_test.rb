require 'test_environment'

class ObjectTest < ActiveSupport::TestCase
  def descendants
    descendants = []
    ObjectSpace.each_object(Object.singleton_class) do |k|
      next if k.singleton_class?
      descendants.unshift k unless k == self
    end
    descendants
  end

  test "responds to .to_bool" do
    assert Object.respond_to?(:to_bool)
  end

  test "responds to #to_bool" do
    assert Object.new.respond_to?(:to_bool)
  end

  test ".to_bool is returns true" do
    assert Object.to_bool
    assert Object.to_bool(strict: true)
    assert (descendants.all? {|desc| desc.to_bool })
  end

  test "#to_bool calls CoerceBoolean.from" do
    given_args =  nil
    given_opts =  nil
    obj        =  Object.new
    false_opts =  { strict: false }
    true_opts  =  { strict: true }
    return_val =  "#from stubbed #{rand}"
    stub       =  ->(*args, **opts) do
                    given_args = args
                    given_opts = opts
                    return_val
                  end

    CoerceBoolean.stub(:from, stub) do
      assert_equal return_val, obj.to_bool
      assert_equal [ obj ],    given_args
      assert_equal false_opts, given_opts

      assert_equal return_val, obj.to_bool(strict: true)
      assert_equal [ obj ],    given_args
      assert_equal true_opts,  given_opts
    end
  end
end
