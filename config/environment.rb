# Load the rails application
require File.expand_path('../application', __FILE__)
# Initialize the rails application
Webistrano::Application.initialize!


require 'open4'
require 'capistrano/cli'
require 'syntax/convertors/html'

# set default time_zone to UTC
ENV['TZ'] = 'UTC'
Time.zone = 'UTC'
