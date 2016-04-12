require 'rails_helper'

RSpec.describe PdfGenerator, type: :service do
  include Capybara::RSpecMatchers

  describe '.for' do
    let(:escort) { instance_double(Escort) }
    let(:html) { '<html>Test document</html>' }

    it 'returns a pdf document' do
      allow(described_class).to receive(:render).and_return(html)
      file = described_class.for(escort)
      expect(file).to be_a_pdf
    end
  end

  describe '.render' do
    attr_reader :page

    before(:all) do
      travel_to(Date.new(2015, 2, 3)) do
        escort = build_stubbed(:escort,
          prisoner: build_stubbed(:prisoner),
          move: build_stubbed(:move),
          risks: build_stubbed(:risks),
          healthcare: build_stubbed(:healthcare),
          offences: build_stubbed(:offences))
        html = described_class.render(escort)
        @page = Capybara::Node::Simple.new(html)
      end
    end

    it 'generates the expected content for the header' do
      header_section = page.find('.first-page')

      expect(header_section).
        to have_content('Person Escort Record').
        and have_content('A1. Cover sheet').
        and have_content('Vehicle registration').
        and have_content('Vehicle cell no')
    end

    it 'generates the expected content for NFR section' do
      not_for_release_section = page.find('.not-for-release')

      expect(not_for_release_section).
        to have_content('Not for release').
        and have_content('Reason').
        and have_content('Cannot be released at the moment').
        and have_css('.marker//.checked')
    end

    context 'move information' do
      it 'generates the expected content for move information section' do
        move_section = page.find_all('.move-information').first

        expect(move_section).
          to have_content('From HMP Clive House').
          and have_content('To Petty France').
          and have_content('Date of travel 3 2 2015').
          and have_content('Destination update')
      end

      it 'generates the expected content for reason for move' do
        move_section = page.find_all('.move-information').last

        expect(move_section).
          to have_content('Reason for move (current offence)').
          and have_content('Expected to attend show the thing')
      end
    end

    it 'generates the expected content for personal information section' do
      prisoner_section = page.find('.prisoner-information')

      expect(prisoner_section).
        to have_content('Family name Bigglesworth').
        and have_content('Forenames Tarquin').
        and have_content('Date of birth 13 2 1972').
        and have_content('Age 42').
        and have_content('Sex M').
        and have_content('Prison number A1234BC').
        and have_content('Nationality British').
        and have_content('Attach photo')
    end

    context 'summary checkboxes' do
      it 'generates the expected content for Open ACCT and CAT A' do
        open_acct_section = page.find_all('.front-page-markers')[0]

        expect(open_acct_section).
          to have_content('ACCT open').
          and have_content('CAT A').
          and have_css('#open_acct-checkbox-group//.checked')
      end

      it 'generates the expected content for healthcare' do
        healthcare_section = page.find_all('.front-page-markers')[1]

        expect(healthcare_section).
          to have_content('Healthcare information').
          and have_content('Allergies').
          and have_content('Disabilities').
          and have_content('Section A3 Healthcare information').
          and have_css('#allergies-checkbox-group//.checked').
          and have_css('#disabilities-checkbox-group//.checked')
      end

      it 'generates the expected content for risks' do
        risks_section = page.find_all('.front-page-markers')[2]

        expect(risks_section).
          to have_content('Risks overview').
          and have_content('Violence').
          and have_content('Escort escape risk').
          and have_content('Non-association').
          and have_content('Section A2 Risk summary').
          and have_css('#violence-checkbox-group//.checked').
          and have_css('#escape-checkbox-group//.checked').
          and have_css('#non_association-checkbox-group//.checked')
      end
    end

    it 'generates the expected content for the risk updates section' do
      updates_section = page.find_all('.updates').first

      expect(updates_section).
        to have_content('Risk updates').
        and have_content('Include relevant updates').
        and have_content('and heightened risks from section B3').
        and have_content('Tick if SASH has been opened')
    end

    it 'generates the expected content for the risk summary section' do
      risk_summary_section = page.find('.risk-summary')

      expect(risk_summary_section).
        to have_content('A2. Risk summary').
        and have_content('PNC / Prison number').
        and have_content('Risks to self').
        and have_content('Always ends up with scars').
        and have_content('Violence and risk to others').
        and have_content('Violent person').
        and have_content('Risk from others').
        and have_content('Several risks from others').
        and have_content('Escort escape risk').
        and have_content('Tried to escape several times').
        and have_content('Intolerant behaviour towards others').
        and have_content('Shouts often').
        and have_content('Prohibited items').
        and have_content('Carried knives several times').
        and have_content('Non-association').
        and have_content('Prisoner with Prison number Z6543XY').
        and have_content('Date of incident').
        and have_content('Name of person filling in this section').
        and have_content('Signature')
    end

    context 'healthcare section' do
      it 'generates the expected content for the healthcare needs' do
        healthcare_needs_section = page.find('.healthcare_needs')

        expect(healthcare_needs_section).
          to have_content('A3. Healthcare information').
          and have_content('Physical health risks').
          and have_content('Problems moving a leg').
          and have_content('Mental health risks').
          and have_content('Schizophrenic').
          and have_content('Social care needs and other healthcare needs').
          and have_content('Needs social care').
          and have_content('Allergies').
          and have_content('Peanuts').
          and have_content('Disabilities').
          and have_content('Strong illness').
          and have_content('Tick if MPV required').
          and have_css('.mpv-required//.checked')
      end

      it 'generates the expected content for the healthcare updates' do
        healthcare_updates_section = page.find('.healthcare-updates')

        expect(healthcare_updates_section).
          to have_content('Name of medical professional').
          and have_content('filling in this section').
          and have_content('Doctor Robert').
          and have_content('Contact phone number').
          and have_content('07987654').
          and have_content('Updates').
          and have_content('This section should be').
          and have_content('completed by a medical professional')
      end

      it 'generates the expected content for the healthcare signpost' do
        healthcare_signpost_section = page.find('.healthcare-signpost')

        expect(healthcare_signpost_section).
          to have_content('Fill in medication details in section B1.')
      end
    end

    it 'generates the expected content for the offences section' do
      offences_section = page.find('.offences')

      expect(offences_section).
        to have_content('A4. Offences').
        and have_content('See A1. Cover sheet for details of current offence').
        and have_content('Other offences').
        and have_content('Must return').
        and have_content('Reason The prisoner must return').
        and have_content('Must not return').
        and have_content('Reason The prisoner must not return').
        and have_content('Use an offence status from the following list').
        and have_content('Outstanding charge').
        and have_content('Serving sentence').
        and have_content('On remand').
        and have_content('License recall').
        and have_content('Verbal abuse').
        and have_css('.must-return//.checked').
        and have_css('.must-not-return//.checked')
    end

    it 'generates the expected content for the handover details section' do
      handover_details_section = page.find('.handover-details')

      expect(handover_details_section).
        to have_content('B1. Handover details').
        and have_content('Fit to travel').
        and have_content('Name of healthcare professional (print)').
        and have_content('Signature').
        and have_content('Role')
    end

    it 'generates the expected content for the medication administration' do
      medication_administration_section =
        page.find('.medication-administration')

      expect(medication_administration_section).
        to have_content('Medication description').
        and have_content('Administration information').
        and have_content('Medication travels with').
        and have_content('Name of medical professional').
        and have_content('professional filling in this section').
        and have_content('Contact phone number')
    end

    it 'generates the expected content for the enclosed forms section' do
      enclosed_forms_section = page.find('.enclosed-forms')

      expect(enclosed_forms_section).
        to have_content('Enclosed forms').
        and have_content('Form').
        and have_content('Attached').
        and have_content('Quantity').
        and have_content('ACCT').
        and have_content('Suicide/Self-Harm Warning').
        and have_content('Cell Sharing risk assessment').
        and have_content('F2050 Core Record').
        and have_content('Property Card').
        and have_content('Categorisation Documentation').
        and have_content('Restraints application form').
        and have_content('Other (please specify)').
        and have_content('Remand Time Calculation').
        and have_content('PNC Printout').
        and have_content('Medical Assessment/Care Plan').
        and have_content('Confidential Medical Documents').
        and have_content('Immigration Detention Authority (IS91)').
        and have_content('Deportation Order').
        and have_content('Warrant')
    end

    it 'generates the expected content for the record of handover section' do
      record_of_handover_section = page.find('.record-of-handover')

      expect(record_of_handover_section).
        to have_content('B2. Record of handover').
        and have_content('Property, cash and medication details').
        and have_content('C - Cash').
        and have_content('D - Documentation').
        and have_content('IP - In possession').
        and have_content('M - Medication').
        and have_content('OAC - Open at Court').
        and have_content('SP - Stored property').
        and have_content('V - Valuables').
        and have_content('Code').
        and have_content('Seal number').
        and have_content('£ value (if cash)').
        and have_content('Initial').
        and have_content('Reseal number').
        and have_content('Reason for opening').
        and have_content('Handover').
        and have_content('Sign to confirm the handover').
        and have_content('of the correct detainee').
        and have_content('and to acknowledge the receipt').
        and have_content('of all sealed property bags.').
        and have_content('Remember to check any added or re-sealed items').
        and have_content('as described above').
        and have_content('Property handover').
        and have_content('(including cash and medication)').
        and have_content('Detainee handover').
        and have_content('Name (print)').
        and have_content('Start location').
        and have_content('Arrival at Court').
        and have_content('Leaving Court').
        and have_content('Arrival at Prison').
        and have_content('Dispatching officer').
        and have_content('Escort').
        and have_content('Receiving officer')
    end

    it 'generates the expected content for the record of checks and events' do
      checks_and_events_section = page.find_all('.checks-and-events').first

      expect(checks_and_events_section).
        to have_content('B3. Record of check').
        and have_content('and significant events').
        and have_content('Checks and significant events').
        and have_content('Time').
        and have_content('Details').
        and have_content('Name (print)').
        and have_content('Initials').
        and have_content('Prisoner identified').
        and have_content('Searched (state level)').
        and have_content('Escort fully briefed (including risks)').
        and have_content('Searched by Contractor (state level)')
    end

    it 'generates the expected content for the continuation markers' do
      continuation_markers_section =
        page.find_all('.continuation-markers').first

      expect(continuation_markers_section).
        to have_content('Tick and sign if this is the').
        and have_content('last page of the record').
        and have_content('Tick if the record continues on a separate sheet')
    end

    it 'generates the expected content for the signature and sheet' do
      signature_and_sheet_section = page.find_all('.signature-and-sheet').first

      expect(signature_and_sheet_section).
        to have_content('Signature').
        and have_content('This is sheet')
    end

    it 'generates the expected content for the checks and events second page' do
      checks_and_events_section = page.find_all('.checks-and-events')[1]

      expect(checks_and_events_section).
        to have_content('Tick this column if the event highlights a current').
        and have_content('risk, and update cover sheet with the information').
        and have_content('When noting any significant events give details').
        and have_content('of behaviour, context and any triggers')
    end

    it 'generates expected content for release at court and property' do
      release_at_court_section = page.find('.release-at-court')

      expect(release_at_court_section).
        to have_content('B4. Release at court').
        and have_content('and receipt of property').
        and have_content('Release at court').
        and have_content('I certify that all relevant checks have been made').
        and have_content('with clearance given as shown').
        and have_content('Agency').
        and have_content('Establishment').
        and have_content('Name').
        and have_content('Authority to release').
        and have_content('Remarks').
        and have_content('Release authorised by SCO / IC').
        and have_content('Name').
        and have_content('Signature').
        and have_content('Release countersigned by').
        and have_content('Statement of receipt of property').
        and have_content('I certify I have received all the contents of the').
        and have_content('property bag numbers shown below,').
        and have_content('and am completely satisfied').
        and have_content('Seal no.').
        and have_content('Name (print)').
        and have_content('Signature')
    end
  end
end
