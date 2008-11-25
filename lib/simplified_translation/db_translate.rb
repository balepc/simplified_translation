module SimplifiedTranslation
  module DbTranslate

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def translates(*factes)
        class_eval <<-HERE
        
          has_many :model_translations, :class_name => 'SimplifiedTranslation::ModelTranslation', :foreign_key=>'record_id'

          def translations
            SimplifiedTranslation::ModelTranslation.set_table_name("#{table_name.singularize}_trls")
            model_translations
          end

        HERE
      
        factes.each do |facet|
          # Метод вилка, возращает значение в зависимости от выбранной локали
          define_method(facet) do
            trl = self.translations.detect{|t| t.language_id == LocaleAdapter.current_language_id}
            text = trl.send(facet) if trl
            text.blank? ? self.read_attribute(facet) : text
          end
          
          # Методы setterы для ввода переводов     (method_ru=)
          LocaleAdapter.all_codes.each do |code|
            language_id = LocaleAdapter.language_id(code)
            define_method("#{facet}_#{code}=") do |translation|
              return if new_record? or translation.blank?
              trl = self.translations.find(:first, :conditions => {:language_id=>language_id})
              trl.update_attribute(facet.to_sym, translation) if trl
              self.translations.create({:language_id=>language_id, facet.to_sym=>translation}) unless trl
              self.reload
            end
          end
        
          # Методы getterы для разных языков       (method_ru)
          LocaleAdapter.all_codes.each do |code|
            language_id = LocaleAdapter.language_id(code)
            define_method("#{facet}_#{code}") do
              return self.read_attribute(facet) if new_record?
              trl = self.translations.detect{|t| t.language_id == language_id}
              text = trl.send(facet) if trl
              return self.read_attribute(facet) if text.nil? and code == LocaleAdapter.base_code
              text
            end
          end
        end
      end
    end
  end
end