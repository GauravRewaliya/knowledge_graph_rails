FactoryBot.define do
  factory :scrapping_table do
    source_type_key { "MyString" }
    url { "MyString" }
    request { "" }
    response { "" }
    filterer_json { "" }
    conveter_code { "MyText" }
    final_clean_response { "" }
    processing_status { "MyString" }
    workspace { nil }
  end
end
