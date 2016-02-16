FactoryGirl.define do
  factory :escort

  factory :prisoner do
    escort
    family_name     'Bigglesworth'
    forenames       'Tarquin'
    prison_number   'A1234BC'
    date_of_birth   Date.new(1972, 2, 13)
    sex             'male'
    nationality     'British'

    trait :empty do
      family_name     nil
      forenames       nil
      prison_number   nil
      date_of_birth   nil
      sex             nil
      nationality     nil
    end
  end

  factory :risk_information do
    escort
  end
end
