FactoryBot.define do
  factory :meaning do
    part_of_speech { "noun" }
    definition { "A thing characteristic of its kind or illustrating a general rule." }
    association :word
  end 
end