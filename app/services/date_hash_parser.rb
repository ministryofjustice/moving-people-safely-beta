class DateHashParser
  InvalidDate = Class.new(OpenStruct)
  EmptyDate   = Class.new(OpenStruct)
  ValidDate   = Class.new(SimpleDelegator)

  def initialize(date_hash = {})
    @date_hash = date_hash
  end

  attr_reader :date_hash
  delegate :values, to: :date_hash, prefix: :date

  def perform
    empty_date || invalid_date || valid_date
  end

private

  def empty_date
    EmptyDate.new(date_hash) if date_values.all?(&:blank?)
  end

  def invalid_date
    InvalidDate.new(date_hash) if non_numerics_or_blanks? ||
                                  less_than_four_digit_year? ||
                                  cannot_coerce_date?
  end

  def valid_date
    ValidDate.new(coerced_date)
  end

  def non_numerics_or_blanks?
    date_values.map(&:to_i).any?(&:zero?)
  end

  def less_than_four_digit_year?
    date_hash[:year].to_i < 1_000
  end

  def coerced_date
    @coerced_date ||=
      Coercible::Coercer.new[Hash].to_date(date_hash)
  rescue ArgumentError
    false
  end

  def cannot_coerce_date?
    coerced_date == false
  end
end
