# frozen_string_literal: true

module IdDocumentTypeHelper
  def translate_id_name(element)
    I18n.t('activerecord.errors.models.id_document_type.' + element.name)
  end
end
