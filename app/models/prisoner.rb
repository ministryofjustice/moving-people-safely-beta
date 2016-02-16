class Prisoner < ActiveRecord::Base
  has_paper_trail
  belongs_to :escort, touch: true
end
