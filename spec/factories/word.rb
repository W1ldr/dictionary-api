FactoryBot.define do
  factory :word do
    sequence(:word) { |n| "word_#{n}" }
    syllabic_division { "example" } # Adjust this as necessary
  end
end
