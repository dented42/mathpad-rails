Fabricator(:user) do
  username { Faker::Internet.user_name }
  email    { Faker::Internet.email }
  password { Faker::Internet.password }
  password_confirmation { |attrs| attrs[:password] }
  ## not using the confirmable module
  # confirmed_at { Date.today }
end
