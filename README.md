# CoerceBoolean
Coerce boolean-like values into their correct values.
Values to use are inspired by ActiveModel::Type::Boolean

## Coercion
Coercion behavior is uses Ruby's boolean semantics with additional parsing.

- `nil` and empty strings are coerced to `nil`
- Any value in `CoerceBoolean::FALSE_VALUES` will be coerced to false
- All other values will be coerced to `true`
  - This includes `0` as a `Float` or `BigDecimal`; only `Integer` `0` is false

If the object passed to `.from` responds to `to_boolean`, coercion will be run
against the result of `to_boolean`

## Strict Mode
Strict Mode always returns a boolean

- `nil` and empty strings are coerced to `false`
- All other values follow the coercion rules above

## `to_bool`
This library adds `to_bool` to the `Object` class to allow users to create
explicit and implicit conversions in the same manner as `to_s` and `to_str`

- There is both a class method (`.to_bool(...)`) and an instance method
(`#to_bool(strict: false)`)
- `.to_bool` will always directly return true unless overridden
- `#to_bool` will call `CoerceBoolean.from` with `self` and `strict` as args


## Examples
- `CoerceBoolean.from("false") # false`
- `CoerceBoolean.from("true") # true`
- `CoerceBoolean.from(1) # true`
- `CoerceBoolean.from(0) # false`
- `CoerceBoolean.from("") # nil`
- `CoerceBoolean.from(nil) # nil`
- `CoerceBoolean.from(nil, strict: true) # false`
- `SomeClass.to_bool # true`
- `"".to_bool # nil`
- `"".to_bool(strict: true) # false`
- `0.to_bool # false`
- `0.0.to_bool # true`
- `0.1.to_bool # true`

## Installation
Add this line to your application's Gemfile:
```ruby
gem 'coerce_boolean'
```
And then execute:
```bash
$ bundle
```

Or add and install directly with bundler:
```ruby
bundle add 'coerce_boolean'
```

Or install it directly with:
```bash
$ gem install coerce_boolean
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
