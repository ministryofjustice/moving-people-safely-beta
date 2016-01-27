class Person < ActiveRecord::Base
  belongs_to :escort

  validates :prison_number, presence: true

  validates :sex, inclusion: %w[ male female ]
end
