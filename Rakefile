# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :elm do
  
  task :compile => [:clean, "app/assets/javascripts/elm/compiled/scratchpads.js"] do
    puts "Generated Elm source files"
  end

  task :clean do
    sh "rm -rvf app/assets/javascripts/elm/compiled"
  end

  directory "app/assets/javascripts/elm/compiled"

  file "app/assets/javascripts/elm/compiled/scratchpads.js" => "app/assets/javascripts/elm/compiled" do
    sh "rm -f app/assets/javascripts/elm/compiled/scratchpads.js"
    sh "elm-make app/assets/javascripts/elm/scratchpads.elm"
    sh "mv elm.js app/assets/javascripts/elm/compiled/scratchpads.js"
  end

end
