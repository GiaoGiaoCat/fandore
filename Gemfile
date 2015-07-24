source 'http://ruby.taobao.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'


# Use Unicorn as the app server
gem 'puma', group: :production

# Make any Ruby object quack like ActiveRecord
gem 'active_type'

# Object-based searching.
gem 'ransack'

# 后台模板相关
gem 'bootstrap-sass'
gem 'font-awesome-rails'

# HTML Abstraction Markup Language
gem 'haml-rails'

# 服务器性能监控
gem 'oneapm_rpm'

gem 'enumerize'
gem 'colorize'
gem 'carrierwave'
gem 'kaminari'
gem 'cancancan'
gem 'aasm' #状态机

group :development do
  gem 'pry-rails'
  gem 'pry-nav'
  gem "quiet_assets"
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'

  # Use Mina for deployment
  gem 'mina'
  gem 'mina-puma', :require => false
end

group :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end
