class RiskInformation < ActiveRecord::Base
  has_paper_trail
  belongs_to :escort
end
