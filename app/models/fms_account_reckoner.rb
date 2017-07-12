require 'net/http'

class FmsAccountReckoner < Struct.new(:user)
  def set_default_fms_status
    if user.fms_number.blank?
      user.fms_status = :fms_blank
      user.is_mwbe = false
    elsif should_clear_status?
      user.is_mwbe = false
      user.fms_status = :fms_pending
    end
  end

  def set!
    update_fms_status
    update_small_business

    if user.changed?
      user.save
    end
  end

#  private

  def update_small_business
    if user.fms_accepted?
      user.is_mwbe = fms_is_mwbe?
    elsif user.fms_blank?
      user.is_mwbe = false
    end
  end

  def update_fms_status
    if user.fms_pending?
      user.fms_status = fms_status
    end
  end

  def should_clear_status?
    user.persisted? && user.fms_number_changed?
  end

  def fms_status
    if fms_is_in_checkbook?
      :fms_accepted
    else
      :fms_rejected
    end
  end

  def vendor_summary
    url_string = ENV['CHECKBOOK_HOST']
    uri = URI.parse url_string

    # First Check the Spending API
    spending_request_string = '<request><type_of_data>Spending</type_of_data><records_from>1</records_from><max_records>1</max_records><search_criteria><criteria><name>payee_code</name><type>value</type><value><fms_number/></value></criteria></search_criteria><response_columns><column>payee_name</column><column>mwbe_category</column></response_columns></request>'

    spending_request = Net::HTTP::Post.new uri.path
    spending_request.body = spending_request_string.sub('<fms_number/>',user.fms_number)
    spending_request.content_type = 'text/xml'
    spending_response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request spending_request }

    spending_record_count = Hash.from_xml(spending_response.body)["response"]["result_records"]["record_count"]

    if spending_record_count.to_f > 0
      spending_vendor_name = Hash.from_xml(spending_response.body)["response"]["result_records"]["spending_transactions"]["transaction"]["payee_name"]
      spending_mwbe_category = Hash.from_xml(spending_response.body)["response"]["result_records"]["spending_transactions"]["transaction"]["mwbe_category"]
    else
      spending_mwbe_category = ''
    end

    # Now Check the Contracts API
    contracts_request_string = '<request><type_of_data>Contracts</type_of_data><records_from>1</records_from><max_records>1</max_records><search_criteria><criteria><name>status</name><type>value</type><value>registered</value></criteria><criteria><name>category</name><type>value</type><value>all</value></criteria><criteria><name>vendor_code</name><type>value</type><value><fms_number/></value></criteria></search_criteria><response_columns><column>vendor</column><column>mwbe_category</column></response_columns></request>'

    contracts_request = Net::HTTP::Post.new uri.path
    contracts_request.body = contracts_request_string.sub('<fms_number/>',user.fms_number)
    contracts_request.content_type = 'text/xml'
    contracts_response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request contracts_request }

    contracts_record_count = Hash.from_xml(contracts_response.body)["response"]["result_records"]["record_count"]

    if contracts_record_count.to_f > 0
      contracts_vendor_name = Hash.from_xml(contracts_response.body)["response"]["result_records"]["contract_transactions"]["transaction"]["vendor"]
      contracts_mwbe_category = Hash.from_xml(contracts_response.body)["response"]["result_records"]["contract_transactions"]["transaction"]["mwbe_category"]
    else
      contracts_mwbe_category = ''
    end

    checkbook_result = {:in_fms=>false, :mwbe=>false}

    if spending_record_count.to_f > 0 || contracts_record_count.to_f > 0
      checkbook_result[:in_fms] = true
    end

    if spending_mwbe_category != 'Non-M/WBE' || contracts.mwbe_category != 'Non-M/WBE'
      checkbook_result[:mwbe] = true
    else
      checkbook_result[:mwbe] = false
    end

    @vendor_summary ||= checkbook_result

  end

  def fms_is_in_checkbook?
    vendor_summary[:in_fms] == true
  end

  def fms_is_mwbe?
    vendor_summary[:mwbe] == true
  end
end
