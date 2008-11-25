class ModelTranslationGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|
        m.migration_template 'migration.rb', 'db/migrate', :assigns => {
          :migration_name => "Create#{class_name.singularize.gsub(/::/, '')}Trls",
          :table_name => "#{class_name.singularize.downcase.gsub(/::/, '')}_trls"
        }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').singularize}_trls"

    end
  end

  protected
    def banner
      "Usage: #{$0} #{spec.name} ModelName"
    end
end

