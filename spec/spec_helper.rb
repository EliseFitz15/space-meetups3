require 'pry'
require 'rspec'
require 'capybara/rspec'

require_relative '../app.rb'

set :environment, :test

Capybara.app = Sinatra::Application

require "database_cleaner"

# this is for database cleaner
RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
#this is for writing capybara tests for user sign in

OmniAuth.config.test_mode = true

def sign_in_as(user)
  mock_omni_auth_for(user)
  visit "/auth/#{user.provider}"
  expect(page).to have_content("You're now signed in as #{user.username}!")
end

def mock_omni_auth_for(user)
  mock_options = {
    uid: user.uid,
    provider: user.provider,
    info: {
      nickname: user.username,
      email: user.email,
      image: user.avatar_url
    }
  }
  OmniAuth.config.add_mock(user.provider.to_sym, mock_options)
end
