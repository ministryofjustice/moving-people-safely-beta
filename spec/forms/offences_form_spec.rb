require 'rails_helper'

RSpec.describe OffencesForm, type: :form do
  input_attributes = {
    not_for_release: 'true',
    not_for_release_details: 'some text',
    must_return: 'false',
    must_return_details: 'some text',
    must_not_return: nil,
    must_not_return_details: 'some text',
    other_offences: nil,
    other_offences_details: 'some text'
  }

  coercion_overrides = {
    not_for_release: true,
    must_return: false,
    must_return_details: nil,
    must_not_return: nil,
    must_not_return_details: nil,
    other_offences: nil,
    other_offences_details: nil
  }

  it_behaves_like 'a form that coerces attributes',
    input_attributes, coercion_overrides
  it_behaves_like 'a form that loads model attributes on initialize'
  it_behaves_like 'a form that syncs to a model'
  it_behaves_like 'a form that retrives or builds its target', :offences
  it_behaves_like 'a form that knows what template to render', 'offences'
  it_behaves_like 'a form that belongs to an endpoint', 'offences'
  it_behaves_like 'a form with a text toggle attribute',
    %i[ not_for_release must_return must_not_return other_offences ]
end
