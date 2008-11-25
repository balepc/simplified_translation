module SimplifiedTranslation
  class LocaleAdapter
    
    def LocaleAdapter.base_code
      Globalite.default_language
    end
  
    def LocaleAdapter.current_code
      Globalite.current_language
    end
  
    def LocaleAdapter.all_codes
      Globalite.languages
    end
  
    def LocaleAdapter.language_id(code)
      case code
      when :lv
        1
      when :en
        2
      when :ru
        3
      end
    end
  
    def LocaleAdapter.base_language_selected?
      current_code == base_code
    end
    
    def LocaleAdapter.current_language_id
      language_id(current_code)
    end
    
  end
end