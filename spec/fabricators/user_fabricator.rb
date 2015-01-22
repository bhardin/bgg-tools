Fabricator(:user) do
  name { Faker::Internet.user_name }
end
