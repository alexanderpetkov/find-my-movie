namespace :elasticsearch do
  namespace :indices do
    desc 'Creates indices for each class that includes Searchable'
    task create: :environment do
      searchables.each { |klass| klass.__elasticsearch__.create_index! }
    end

    desc 'Refresh all indices (e.g. when you change an indexing setting)'
    task refresh: :environment do
      searchables.each do |klass|
        klass.__elasticsearch__.create_index! force: true
      end
    end

    desc 'Refresh and reimport all indices'
    task refresh_and_reimport: ['indices:refresh', 'import']
  end

  desc 'Imports all Searchable models'
  task import: :environment do
    searchables.each(&:import)
  end

  def searchables
    Rails.application.eager_load!

    models = ApplicationRecord.descendants
    models.select { |m| m.included_modules.include? Searchable }
  end
end
