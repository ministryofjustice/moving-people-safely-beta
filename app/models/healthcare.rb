class Healthcare < ActiveRecord::Base
  MAX_MEDICATIONS_COUNT = 6

  has_paper_trail
  belongs_to :escort, touch: true
  has_many :medications
  accepts_nested_attributes_for :medications, allow_destroy: true

  def backfilled_medications(klass = Medication)
    number_to_backfill = MAX_MEDICATIONS_COUNT - medications.size
    medications + Array.new(number_to_backfill) { klass.new }
  end
end
