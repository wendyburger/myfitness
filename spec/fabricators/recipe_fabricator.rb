Fabricator(:recipe) do
  dishname {Faker::Lorem.words(5).join(" ")}
  protocol {Faker::Lorem.paragraph(1)}
  image {Faker::Placeholdit.image}
end