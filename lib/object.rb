# frozen_string_literal: true

class Object
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Boolean Class Methods ================================================

  # == Class Methods ========================================================
  def self.to_bool(...)
    true
  end

  # == Boolean Methods ======================================================

  # == Instance Methods =====================================================
  def to_bool(strict: false)
    CoerceBoolean.from(self, strict: strict)
  end
end
