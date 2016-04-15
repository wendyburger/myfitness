Fabricator(:post) do
  title {Faker::Lorem.words(5).join(" ")}
  description {Faker::Lorem.paragraph(1)}
  category_id {[ 1..9 ].sample}
  content {Faker::Internet.url('www.youtube.com')}
  image {Faker::Placeholdit.image}
end