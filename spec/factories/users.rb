FactoryBot.define do
    sequence :email do |n|
        "mail@gmail#{n}.ua"
    end

    factory :user do
        email
        name 'Ford Perfect'
        password '12345678'
        password_confirmation '12345678'
        factory :admin_user do
            after(:create) { |user| user.add_role(:admin) }
        end
        factory :group_user do
            after(:create) { |user| user.add_role(:group) }
        end
        factory :book_user do
            after(:create) { |user| user.add_role(:book) }
        end
    end
end