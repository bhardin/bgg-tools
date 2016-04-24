source 'https://rubygems.org'

gem 'bgg-api', :github => 'bhardin/bgg-api', :ref => 'ef3680077cce3b53b163b52374494bc2c94d89d8'
gem 'friendly_id'
gem 'less-rails-bootstrap'
gem 'mysql2', '~> 0.3.10'
gem 'rake'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil # For sidekiq interface
gem 'therubyracer'
gem 'unicorn'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'capistrano', '~> 3.3.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-unicorn-nginx', '~> 3.2.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rbenv', '~> 2.0' 
  gem 'capistrano-rbenv-install', '~> 1.2.0'
  gem 'capistrano-sidekiq'
  gem 'guard'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'awesome_print'
end

group :test do
  gem 'webmock'
  gem 'fabrication'
  gem 'rspec-rails', '~> 2.0'
  gem 'coveralls', require: false
  gem 'vcr'
  gem 'faker'
end
