class Form
  class MaybeBoolean < Virtus::Attribute::Boolean
    def coerce(value)
      super if super.in? [true, false]
    end
  end
end
