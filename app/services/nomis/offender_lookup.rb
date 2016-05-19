module Nomis
  class OffenderLookup
    API_URL_BASE      = ENV.fetch('NOMIS_API_URL_BASE')
    DETAILS_ENDPOINT  = 'offender_details'
    IMAGES_ENDPOINT   = 'offender_images'
    CHARGES_ENDPOINT  = 'offender_charges'

    class Result < SimpleDelegator
      def success?
        is_a? Net::HTTPSuccess
      end

      def data
        @data ||= body.blank? ? {} : JSON.parse(body)
      end
    end

    def initialize(identifier, endpoint:)
      @identifier, @endpoint = identifier, endpoint
    end

    def self.details(identifier)
      new(identifier, endpoint: DETAILS_ENDPOINT)
    end

    def self.images(identifier)
      new(identifier, endpoint: IMAGES_ENDPOINT)
    end

    def self.charges(identifier)
      new(identifier, endpoint: CHARGES_ENDPOINT)
    end

    def call
      Result.new Net::HTTP.get_response(uri)
    end

    private

    def uri
      URI("#{API_URL_BASE}#{@endpoint}").tap do |u|
        u.query = URI.encode_www_form(noms_id: @identifier)
      end
    end
  end
end
