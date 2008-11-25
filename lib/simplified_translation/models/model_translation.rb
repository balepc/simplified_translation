module SimplifiedTranslation
  class ModelTranslation < ActiveRecord::Base
    belongs_to :language
    validates_uniqueness_of :record_id, :scope => :language_id
  end
end