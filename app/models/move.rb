class Move < ActiveRecord::Base
  has_paper_trail
  belongs_to :escort, touch: true

  def self.default_origin_option
    { origin: I18n.t('escorts.move_information.default_origin') }
  end
end
