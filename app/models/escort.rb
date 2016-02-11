class Escort < ActiveRecord::Base
  has_paper_trail
  has_one :prisoner
end
