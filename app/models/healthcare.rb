class Healthcare < ActiveRecord::Base
  has_paper_trail
  belongs_to :escort, touch: true
  has_many :medications
end
