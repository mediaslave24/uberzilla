FactoryGirl.define do
  sequence :email do |n|
    "the-email#{n}@example.org"
  end

  sequence :username do |n|
    "John Smith#{n}"
  end

  sequence :random_name do |n|
    "Lorem Ipsum #{n}"
  end

  factory :department do
    name { generate :random_name }
  end

  factory :ticket_status do
    name { generate :random_name }
  end

  factory :user do
    name { generate :username }
    email
    password 'password'

    factory :staff, class: Staff do
      department
      type 'Staff'
    end

    factory :admin, class: Admin do
      type 'Admin'
    end
  end

  factory :customer do
    name { generate :username }
    email
  end

  factory :ticket do
    status factory: :ticket_status
    staff
    department
    subject { generate :random_name }
    body { generate :random_name }
  end
end
