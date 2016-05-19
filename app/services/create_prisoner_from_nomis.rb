class Nationality
  include Virtus.value_object

  attribute :nationality, String
end

class OffenderDetails
  include Virtus.value_object

  attribute :prison_number, String
  attribute :forenames, String
  attribute :surname, String
  attribute :birth_date, Date
  attribute :nationalities, Array[Nationality]
  attribute :sex, String
  attribute :cro_number, String
  attribute :pnc_number, String
  attribute :working_name, Boolean
  attribute :agency_location, String

  def nationalities
    super.map(&:nationality).join(', ')
  end

  def sex
    case super
    when /m/i then 'male'
    when /f/i then 'female'
    end
  end
end

class OffenderDetailsResult
  include Virtus.value_object

  attribute :offenderdetails, Array[OffenderDetails]
  alias_method :offender_details, :offenderdetails
end

class OffenderImagesResult
  include Virtus.value_object

  attribute :image, String
  attribute :thumbnail_image, String
end

module DowncasedHashKeys
  refine Hash do
    def downcase_keys
      {}.tap do |h|
        self.each { |key, value| h[key.downcase] = downcase_keys_transform(value) }
      end
    end

    private def downcase_keys_transform(value)
      case value
      when Hash   then value.downcase_keys
      when Array  then value.map { |v| downcase_keys_transform(v) }
      else value
      end
    end
  end
end

class CreatePrisonerFromNomis
  using DowncasedHashKeys

  def initialize(prison_number)
    @prison_number = prison_number
  end

  def call
    offender_details_lookup = log_time(tag: "Offender details lookup") {
      Nomis::OffenderLookup.details(@prison_number).call
    }

    offender_details_result = OffenderDetailsResult.new(
      offender_details_lookup.data.downcase_keys
    )

    offender_images_lookup = log_time(tag: "Offender images lookup") {
      Nomis::OffenderLookup.images(@prison_number).call
    }

    offender_images_result = OffenderImagesResult.new(
      offender_images_lookup.data.downcase_keys
    )

    offender_details = offender_details_result.offender_details.find(&:working_name)

    {
      family_name: offender_details.surname,
      forenames: offender_details.forenames,
      date_of_birth: offender_details.birth_date,
      sex: offender_details.sex,
      nationality: offender_details.nationalities,
      base_64_image: offender_images_result.thumbnail_image
    }
  end

  private

  def log_time(tag:, &blk)
    start = Time.now
    res = yield
    Rails.logger.info "#{tag} took: #{(Time.now - start)*1000}ms"

    res
  end
end
