Fabricator(:review) do
  description { Faker::Lorem.paragraph(3) }
  rating 5
end