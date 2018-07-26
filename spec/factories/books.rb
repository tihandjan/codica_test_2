FactoryBot.define do
  factory :book do
    title "MyString"
    picture { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'files', 'test.png'), 'image/jpeg') }
  end
end
