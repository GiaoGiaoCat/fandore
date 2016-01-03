# source 'http://ruby.taobao.org'
source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.4.2'
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
gem 'gon'

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
# Simple Rails app configuration
gem 'figaro'
# ActiveRecord plugin allowing you to hide and restore records without actually deleting them.
gem 'paranoia'
# ChinaCity 省市区级联选择
gem 'china_city', '0.0.5', github: 'wjp2013/china_city'
# An ActiveRecord plugin for managing lists
gem 'acts_as_list'
# Allows for favorite refer to be added to multiple and different models.
gem 'acts_as_favable', github: 'coderxin/acts_as_favable'
# Organise ActiveRecord model into a tree structure
gem 'ancestry'
# State machines for Ruby classes (plain Ruby, ActiveRecord, Mongoid, MongoMapper)
gem 'aasm'
# Turn your controller into a wizard.
gem 'wicked'
# Provides a single Comment model that can be attached to any model(s) within your app.
gem 'acts_as_commentable'
# Classier solution for Multiple file uploads for Multiple file upload.
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick'
# Captcha into a Rails application
gem 'simple_captcha_reloaded'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator.
gem 'kaminari'
# CanCan is an authorization library for Ruby on Rails
gem 'cancancan', '~> 1.10'
# An unofficial alipay ruby gem
gem 'alipay', github: 'chloerei/alipay'
# An unofficial simple wechat pay gem
gem 'wx_pay'
gem 'rqrcode_png'

# Use Puma as the app server
gem 'puma', group: :production
# 服务器性能监控
gem 'oneapm_rpm'

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
  gem 'colorize'
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
