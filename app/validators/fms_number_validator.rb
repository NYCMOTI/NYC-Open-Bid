
class FmsNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !value.blank? && invalid_fms_number?(value)
      record.errors[attribute] << I18n.t('activerecord.errors.models.user.attributes.duns_number.invalid')
    end
  end

  private

  def invalid_fms_number?(value)
    !contains_ten_integers?(value)
  end

  #TODO Do we need to adjust regex to also match FMS IDs like: VC00160364, VS00021011
  #TODO Should we allow fewer than 10 digits and just append the zeroes for the user?

  def contains_ten_integers?(fms_number)
    if fms_number.present?
      fms_number.match(/\A[0-9Vv][0-9SsCc]\d{8}\z/)
    end
  end
end
