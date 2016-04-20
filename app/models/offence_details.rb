class OffenceDetails < ActiveRecord::Base
  has_paper_trail
  belongs_to :offences, touch: true
end
