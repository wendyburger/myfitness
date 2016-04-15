Fabricator(:comment) do
  body {Faker::Lorem.sentence}
end