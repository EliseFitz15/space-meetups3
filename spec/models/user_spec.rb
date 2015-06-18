require "sinatra"
require "sinatra/activerecord"
require "shoulda-matchers"
require_relative "../../app/models/meetup.rb"



describe Meetup do

  it { should validate_presence_of(:name) }

end
