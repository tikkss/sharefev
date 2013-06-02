namespace :load_init_data do
  desc "loading init bookmarks data"
  task bookmarks: :environment do
    ENV['FIXTURES_PATH'] = "db/bookmark_fixtures"
    Rake::Task['db:fixtures:load'].execute
  end
end
