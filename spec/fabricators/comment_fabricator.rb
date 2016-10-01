Fabricator(:comment) do
  body { Faker::Lorem.name }
  author { Fabricate(:user) }
  commentable_type { "Article" }
  commentable_id { Fabricate(:article).id }
end



