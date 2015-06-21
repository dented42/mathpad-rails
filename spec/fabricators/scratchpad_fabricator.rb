Fabricator(:scratchpad) do
  title       { Faker::App.name }
  description { Faker::Hacker.adjective + " " + Faker::Hacker.ingverb + " " + Faker::Hacker.noun }

  user
end
