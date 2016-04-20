class Offences < ActiveRecord::Base
  MAX_OFFENCE_DETAILS_COUNT = 6

  has_paper_trail
  belongs_to :escort, touch: true
  has_many :offence_details
  accepts_nested_attributes_for :offence_details, allow_destroy: true

  def backfilled_offence_details(offence_details_forms = [])
    filled_objects = if offence_details_forms.any?
                       offence_details_forms
                     else
                       offence_details
                     end
    number_to_backfill = MAX_OFFENCE_DETAILS_COUNT - filled_objects.size
    filled_objects + Array.new(number_to_backfill) { OffenceDetails.new }
  end
end
