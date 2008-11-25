require 'simplified_translation/models/model_translation'
require 'simplified_translation/adapters/locale_adapter'

class ActiveRecord::Base # :nodoc:
  include SimplifiedTranslation::DbTranslate
end