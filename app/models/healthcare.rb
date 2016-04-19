class Healthcare < ActiveRecord::Base
  MAX_MEDICATIONS_COUNT = 6

  has_paper_trail
  belongs_to :escort, touch: true
  has_many :medications
  accepts_nested_attributes_for :medications, allow_destroy: true

  def backfilled_medications(medication_forms = [])
    filled_objects = if medication_forms.any?
                       medication_forms
                     else
                       medications
                     end
    number_to_backfill = MAX_MEDICATIONS_COUNT - filled_objects.size
    filled_objects + Array.new(number_to_backfill) { Medication.new }
  end
end
