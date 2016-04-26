class Healthcare < ActiveRecord::Base
  MAX_MEDICATIONS_COUNT = 6

  has_paper_trail
  belongs_to :escort, touch: true
  has_many :medications
  accepts_nested_attributes_for :medications, allow_destroy: true

  def backfilled_medications
    BackfillCollection.call(medications) { Medication.new }.
      take(MAX_MEDICATIONS_COUNT)
  end
end
