FactoryBot.define do
  factory :upload do
    file_name { "test.xml" }
    status { "processing" }
    error_message { "" }
    association :customer
  end
end
