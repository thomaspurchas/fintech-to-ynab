ruby '2.5.1'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rest-client'
gem 'rails', '~> 6.0.3', '>= 6.0.3.5'
gem 'puma', '~> 3.7'
gem 'money'

# Fintech Providers
gem 'ynab'
gem 'starling-ruby', require: 'starling'

# Notifiers
gem 'washbullet'

# Utilities
gem 'awesome_print'
gem 'commander'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'listen'
  gem 'dotenv-rails', '>= 2.7.0'
  gem 'rubocop-rails_config', '>= 0.2.2'
end

group :test do
  gem 'rspec-rails', '>= 3.8.0'
  gem 'codecov'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
