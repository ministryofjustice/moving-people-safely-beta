module CompatibleDate
  EmptyDate = Class.new(OpenStruct) do
    def invalid?
      false
    end
  end
  InvalidDate = Class.new(OpenStruct) do
    def invalid?
      true
    end
  end
  ValidDate = Class.new(SimpleDelegator) do
    def invalid?
      year < 1_000
    end
  end

module_function

  def for(value)
    case value
    when Date then value
    when Hash then coerce_hash(value)
    end
  end

  def coerce_hash(date_hash)
    return EmptyDate.new(date_hash) if empty_date_hash?(date_hash)
    return InvalidDate.new(date_hash) if invalid_date?(date_hash)
    ValidDate.new(Coercible::Coercer.new[Hash].to_date(date_hash))
  rescue ArgumentError
    InvalidDate.new(date_hash)
  end

  def empty_date_hash?(date)
    date.values.all?(&:blank?)
  end

  def invalid_date?(date)
    date.values.map(&:to_i).any?(&:zero?)
  end
end
