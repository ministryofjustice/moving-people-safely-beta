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

    trait :with_risks do
      after :create do |escort|
        create :risks, escort: escort
      end
    end

    trait :with_move do
      after :create do |escort|
        create :move, escort: escort
      end
    end

    trait :with_healthcare do
      after :create do |escort|
        create :healthcare, escort: escort
      end
    end

    trait :with_offences do
      after :create do |escort|
        create :offences, escort: escort
      end
    end
  end

  factory :prisoner do
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

  factory :risks do
    to_self true
    to_self_details 'Always ends up with scars'
    open_acct true
    violence true
    violence_details 'Violent person'
    from_others true
    from_others_details 'Several risks from others'
    escape true
    escape_details 'Tried to escape several times'
    intolerant_behaviour true
    intolerant_behaviour_details 'Shouts often'
    prohibited_items true
    prohibited_items_details 'Carried knives several times'
    non_association true
    non_association_details 'Prisoner with Prison number Z6543XY'
  end

  factory :user do
    first_name 'Henry'
    last_name 'Pope'
    job_role 'Reception'
    email 'staff@some.prison.com'
    password 'secret123'
    password_confirmation 'secret123'
  end

  factory :move do
    origin 'HMP Clive House'
    destination 'Petty France'
    date_of_travel { Date.today }
    reason 'Expected to attend show the thing'
  end

  factory :healthcare do
    physical_risk true
    physical_risk_details 'Problems moving a leg'
    mental_risk true
    mental_risk_details 'Schizophrenic'
    social_care_and_other true
    social_care_and_other_details 'Needs social care'
    allergies true
    allergies_details 'Peanuts'
    disabilities true
    mpv_required true
    disabilities_details 'Strong illness'
    medication true
    medical_professional_name 'Doctor Robert'
    contact_telephone '07987654'
  end

  factory :medication do
    description 'Aspirin'
    administration 'Once a day'
    carrier 'escort'
  end

  factory :medication_attributes, class: Hash do
    id nil
    description 'Aspirin'
    administration 'Once a day'
    carrier 'escort'
    _destroy nil

    trait :empty do
      description ''
      administration ''
      carrier ''
    end

    trait :mark_for_destroy do
      _destroy true
    end

    initialize_with { attributes }
  end

  factory :offences do
    not_for_release true
    not_for_release_details 'Cannot be released at the moment'
    must_return true
    must_return_details 'The prisoner must return'
    must_not_return true
    must_not_return_details 'The prisoner must not return'
  end

  factory :offence_details do
    offence_type 'Burglary'
    offence_status 'outstanding_charge'
    not_for_release true
    current_offence true
  end

  factory :offence_details_attributes, class: Hash do
    id nil
    offence_type 'Burglary'
    offence_status 'outstanding_charge'
    not_for_release true
    current_offence true
    _destroy nil

    trait :empty do
      offence_type ''
      offence_status ''
      not_for_release nil
      current_offence nil
    end

    trait :mark_for_destroy do
      _destroy true
    end

    initialize_with { attributes }
  end
end
