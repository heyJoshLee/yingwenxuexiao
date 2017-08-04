Fabricator(:affiliate_link) do
  name { Faker::Lorem.name}
  random_string = SecureRandom.urlsafe_base64
  slug { random_string }
  affiliate_id { (1..100).to_a.sample }
  url { "www.yingwenxuexiao.com/" + random_string }

end



