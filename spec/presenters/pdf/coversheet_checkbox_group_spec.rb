require 'rails_helper'

RSpec.describe Pdf::CoversheetCheckboxGroup, type: :presenter do
  subject { described_class.new(:attribute_name, true) }

  its(:attribute) { is_expected.to eq :attribute_name }

  context 'when value is true' do
    subject { described_class.new(:attribute_name, true) }
    its(:yes_checkbox_class)  { is_expected.to eq 'checked' }
    its(:no_checkbox_class)   { is_expected.to be_nil }
  end

  context 'when value is false' do
    subject { described_class.new(:attribute_name, false) }
    its(:yes_checkbox_class)  { is_expected.to be_nil }
    its(:no_checkbox_class)   { is_expected.to eq 'checked' }
  end

  context 'when value is nil' do
    subject { described_class.new(:attribute_name, nil) }
    its(:yes_checkbox_class)  { is_expected.to be_nil }
    its(:no_checkbox_class)   { is_expected.to be_nil }
  end
end
