FactoryGirl.define do
  factory :escort do
    trait :with_prisoner do
      transient do
        prison_number 'A1234BC'
      end

      after :create do |escort, evaluator|
        create :prisoner, escort: escort, prison_number: evaluator.prison_number
      end
    end
  end

  factory :prisoner do
    escort
    family_name     'Bigglesworth'
    forenames       'Tarquin'
    prison_number   'A1234BC'
    date_of_birth   Date.new(1972, 2, 13)
    sex             'male'
    nationality     'British'
    cro_number      'SOMECRO'
    pnc_number      'SOMEPNC'

    trait :empty do
      family_name     nil
      forenames       nil
      prison_number   nil
      date_of_birth   nil
      sex             nil
      nationality     nil
      cro_number      nil
      pnc_number      nil
    end
  end

  factory :risk_information do
    escort
  end

  factory :user do
    first_name 'Mark'
    last_name 'White'
    job_role 'Reception'
    email 'mark.white@some.prison.com'
    password 'secret123'
    password_confirmation 'secret123'
  end
end
