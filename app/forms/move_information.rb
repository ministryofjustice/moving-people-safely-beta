class MoveInformation < Form
  include Form::DateHandling

  attribute :origin,      String
  attribute :destination, String
  attribute :reason,      String
  date :date_of_travel

  validates :date_of_travel, present_or_future_date: true

  def formatted_date_today
    Date.today.strftime('%d %m %Y')
  end

  def target
    super.move
  end
end
