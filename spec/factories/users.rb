FactoryBot.define do
    sequence :email do |n|
        "mail@gmail#{n}.ua"
    end

    factory :user do
        email
        name 'Ford Perfect'
        password '12345678'
        password_confirmation '12345678'
    end
end