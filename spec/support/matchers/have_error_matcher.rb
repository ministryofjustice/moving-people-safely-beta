RSpec::Matchers.define :have_error_for do |attribute|
  match do |model|
    model_errors = model.errors[attribute]
    model_errors.any? && (@msg.blank? || model_errors.grep(@msg).any?)
  end

  chain :with_message do |msg|
    @msg = msg
  end

  failure_message do
    "expected model to have errors for #{attribute}"
  end
end
