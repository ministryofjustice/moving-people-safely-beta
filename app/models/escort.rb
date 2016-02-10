class Escort < ActiveRecord::Base
  has_paper_trail
  has_one :prisoner
  has_one :risk_information
end
