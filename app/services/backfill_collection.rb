module BackfillCollection
  def call(collection, &_backfill_object)
    Enumerator.new do |y|
      collection.reduce(y, &:<<)
      loop do
        y << yield
      end
    end
  end

  module_function :call
end
