Fabricator(:video) do
  title { Faker::Lorem.words(2).join(" ") }
  description { Faker::Lorem.sentence(10) }
end