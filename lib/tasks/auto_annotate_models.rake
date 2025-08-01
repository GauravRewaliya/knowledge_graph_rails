# lib/tasks/auto_annotate_models.rake

namespace :custom_annotate do
  desc "Annotate models with schema information"
  task models: :environment do
    Dir.glob(Rails.root.join("app/models/**/*.rb")).each do |file|
      model = File.basename(file, ".rb").camelize
      klass = model.safe_constantize
      next unless klass.is_a?(Class) && klass < ApplicationRecord
      next unless klass.table_exists?

      info = klass.columns.map { |c| "#  #{c.name.ljust(20)} :#{c.type}" }
      header = [
        "# == Schema Information",
        "#",
        "# Table name: #{klass.table_name}",
        "#",
        *info,
        "#"
      ].join("\n")

      content = File.read(file)
      cleaned = content.sub(/\A(# == Schema Information(.|\n)*?#\n)?/, "")
      File.write(file, "#{header}\n\n#{cleaned}")
      Rails.logger.info "Annotated: #{file}"
    end
  end
end

Rake::Task["db:migrate"].enhance(["custom_annotate:models"])
