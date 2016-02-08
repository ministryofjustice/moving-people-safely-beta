class DateHashParser
  def initialize(date)
    @date = date
  end

  attr_reader :date
  delegate :values, to: :date, prefix: true
  delegate :nil_date, :empty_date, :valid_date, :invalid_date,
    to: :ParsedDate, prefix: :create

  def build
    nil_date || current_date || empty_date || invalid_date || valid_date
  end

private

  def nil_date
    create_nil_date if date.nil?
  end

  def current_date
    create_valid_date(date) if date.is_a? Date
  end

  def empty_date
    create_empty_date(date) if date_values.all?(&:blank?)
  end

  def invalid_date
    create_invalid_date(date) if non_numerics_or_blanks? ||
                                 less_than_four_digit_year? ||
                                 cannot_coerce_date?
  end

  def valid_date
    create_valid_date(coerced_date)
  end

  def non_numerics_or_blanks?
    date_values.map(&:to_i).any?(&:zero?)
  end

  def less_than_four_digit_year?
    date[:year].to_i < 1_000
  end

  def coerced_date
    @coerced_date ||= Coercible::Coercer.new[Hash].to_date(date)
  rescue ArgumentError
    false
  end

  def cannot_coerce_date?
    coerced_date == false
  end
end
