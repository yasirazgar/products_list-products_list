module ApplicationHelper

  def value_or_not_set(value)
    value.blank? ? t('common.not_set') : value
  end

end
