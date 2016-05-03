require 'rails_helper'

RSpec.describe LinkToFieldWithErrorHelper, type: :helper do
  let(:form_object) { RisksForm.new(create :escort) }

  describe '#link_to_field_with_error' do
    context 'when field contains _details' do
      it 'removes _details from the link to the field' do
        expect(helper.link_to_field_with_error(form_object, :to_self_details)).
          to eq "<a href=\"#risks_to_self\">#risks_to_self</a>"
      end
    end

    context 'when field does not contain _details' do
      it 'creates link to field' do
        expect(helper.link_to_field_with_error(form_object, :to_self)).
          to eq "<a href=\"#risks_to_self\">#risks_to_self</a>"
      end
    end

    context 'when object is a form_object' do
      it 'removes _form from the link to the field' do
        expect(helper.link_to_field_with_error(form_object, :to_self_details)).
          to_not eq "<a href=\"#risks_form_to_self\">#risks_form_to_self</a>"
      end
    end
  end
end
