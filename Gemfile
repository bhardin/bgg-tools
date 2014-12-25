source 'https://rubygems.org'

gem 'rake'
gem 'bgg-api', :github => 'bhardin/bgg-api', :ref => 'ef3680077cce3b53b163b52374494bc2c94d89d8'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil # For sidekiq interface
gem 'therubyracer'
gem 'less-rails-bootstrap'
gem 'friendly_id'
gem 'mysql2'
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

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'awesome_print'
	gem 'capistrano', '~> 3.3.0'
	gem 'capistrano-rvm'
	gem 'capistrano-bundler', '~> 1.1.2'
	gem 'capistrano-rails', '~> 1.1'
	gem 'capistrano-nginx-unicorn'
	gem 'capistrano-sidekiq'
end
