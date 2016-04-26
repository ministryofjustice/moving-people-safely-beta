class Offences < ActiveRecord::Base
  MAX_OFFENCE_DETAILS_COUNT = 6

  has_paper_trail
  belongs_to :escort, touch: true
  has_many :offence_details
  accepts_nested_attributes_for :offence_details, allow_destroy: true

  def backfilled_offence_details
    BackfillCollection.call(offence_details) { OffenceDetails.new }.
      take(MAX_OFFENCE_DETAILS_COUNT)
  end
end
