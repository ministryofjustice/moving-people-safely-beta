class Medication < ActiveRecord::Base
  has_paper_trail
  belongs_to :healthcare, touch: true
end
