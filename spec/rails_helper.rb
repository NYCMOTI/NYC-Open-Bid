ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'dotenv'
Dotenv.load
require 'capybara/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  OmniAuth.config.test_mode = true

  config.before do
    mock_github
    WebMock.stub_request(:any, /api.data.gov/).to_rack(FakeSamApi)
    WebMock.stub_request(:any, /tock.18f.gov/).to_rack(FakeTockApi)
    WebMock.stub_request(:any, /cap.18f.gov/).to_rack(FakeC2Api)
    WebMock.stub_request(:any, /c2-dev.18f.gov/).to_rack(FakeC2Api)
    WebMock.stub_request(:any, /api.github.com/).to_rack(FakeGitHubApi)
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
