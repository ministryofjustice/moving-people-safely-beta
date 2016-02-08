class ParsedDate < SimpleDelegator
  EMPTY_DATE_HASH = { day: '', month: '', year: '' }

  class << self
    def nil_date
      new(struct_date(EMPTY_DATE_HASH), valid_date: true)
    end

    def empty_date(obj)
      new(struct_date(obj), valid_date: true)
    end

    def valid_date(obj)
      new(obj, valid_date: true)
    end

    def invalid_date(obj)
      new(struct_date(obj), valid_date: false)
    end

    def struct_date(date_hash)
      OpenStruct.new(date_hash)
    end
  end

  def initialize(obj, options)
    @valid_date = options.fetch(:valid_date)
    super(obj)
  end

  def valid?
    @valid_date
  end

  def to_date
    __getobj__&.to_date
  end
end
