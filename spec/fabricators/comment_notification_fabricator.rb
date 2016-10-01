Fabricator(:comment_notification) do
  comment_id { Fabricate(:comment).id }
  user_id { Fabricate(:user).id }
  message { Faker::Lorem.paragraph }
end
