namespace :elasticsearch do
  desc 'Creates indices for each class that includes Searchable'
  task create_indices: :environment do
    searchables.each do |klass|
      klass.__elasticsearch__.create_index!
    end
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
