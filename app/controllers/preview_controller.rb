class PreviewController < ApplicationController
  layout 'pdf'

  def show
    @escort_record = {
      print_type: 'Master', escort_date: '10/12/2015',
      family_name: 'Smith', forenames: 'John Mark',
      dob_day: 01, dob_month: 10, dob_year: 1995,
      age: 20, sex: 'M', nationality: 'British', prison_number: 'A1234BC'
    }
  end
end
