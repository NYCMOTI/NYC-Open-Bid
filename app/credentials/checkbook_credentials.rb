require 'concerns/user_provided_service'

class CheckbookCredentials
  extend UserProvidedService

  def self.host
    ENV['CHECKBOOK_HOST']
  end

end
