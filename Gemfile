source "http://rubygems.org"

gem "whenever"
gem "delayed_job"
gem "daemons"
gem 'bundler', "1.2.1"
gem "mysql2", "0.3.11"
gem 'rails', '3.2.8'
gem "erubis"
gem "rake", "0.9.2.2"
gem "rdoc"
gem "syntax",     '1.0.0'
gem "capistrano", '~> 2.13'
gem "open4",      '0.9.3'
gem "version_fu", :git =>  'git://github.com/jmckible/version_fu.git'
gem "exception_notification"
gem 'devise'
gem 'devise-encryptable'
gem 'haml'

group :development do
  gem "debugger"
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem 'rack-livereload'

end

group :test do
  gem "debugger"
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'test-unit'
  gem 'mocha'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'launchy'

  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'capybara'

  gem 'guard'

  gem 'spork'
  gem 'rb-fsevent'
  gem 'guard-test'
  gem 'guard-rspec'
  gem 'guard-spork'
end

group :production do
  gem 'unicorn'
end

group :assets do
  gem 'jquery-rails'
  gem 'prototype-rails'

  gem 'compass'
  gem 'compass-rails'
  gem 'sass-rails'
  gem 'coffee-rails'

  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
end
