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
# Official Sass port of Bootstrap
gem 'bootstrap-sass'
# the font-awesome font bundled as an asset for the rails asset pipeline
gem 'font-awesome-rails'
# HTML Abstraction Markup Language
gem 'haml-rails'
# Forms made easy for Rails! It's tied to a simple DSL, with no opinion on markup.
gem 'simple_form'
# Dynamic nested forms using jQuery made
gem 'cocoon'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Make any Ruby object quack like ActiveRecord
gem 'active_type'
# Object-based searching.
gem 'ransack'
# ActiveModel::Otp makes adding Two Factor Authentication (TFA) to a model simple.
gem 'active_model_otp'
# Enumerated attributes with I18n and ActiveRecord/Mongoid support
gem 'enumerize'
# Simple Rails app configuration
gem 'figaro'
# ActiveRecord plugin allowing you to hide and restore records without actually deleting them.
gem 'paranoia'
# ChinaCity 省市区级联选择
gem 'china_city'
# An ActiveRecord plugin for managing lists
gem 'acts_as_list'

# patterns to build a simple, robust and scaleable authorization system.
gem 'pundit'
# Use Puma as the app server
gem 'puma', group: :production
# 服务器性能监控
gem 'oneapm_rpm'

# others
gem 'colorize'
gem 'carrierwave'
gem 'kaminari'
gem 'cancancan'
gem 'aasm' #状态机

# others
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development do
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print'
  gem 'i18n-debug'
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
