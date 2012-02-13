source 'http://ruby.taobao.org/'

gem 'rails', '3.2.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# MongoDB
gem "mongoid", "~> 2.4"
gem "bson_ext", "~> 1.5"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'


group :development do
  gem 'pry'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem "letter_opener"
  gem 'guard-spork'
  gem "rspec-rails"
  # gem 'railroady'
  # gem 'rails-footnotes'
  # gem 'linecache19'
end


group :test do
  gem 'turn', '0.8.2', :require => false
  gem 'pry'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem "factory_girl_rails", "~> 1.2"
  gem 'capybara'
  gem 'guard-rspec'
  gem 'rspec-rails'
  
  # gem 'cucumber-rails'
  # database_cleaner is not required, but highly recommended
  # gem 'database_cleaner'
end



# 用户系统
gem 'devise'
gem 'devise_lastseenable'


# 分词
gem 'chinese_pinyin'
gem 'rmmseg-cpp-huacnlee'

# 图片上传
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'mini_magick'

# 分页
gem 'will_paginate'#,:require=>'will_paginate/array'
gem "will_paginate_mongoid"

# Redis
gem "redis"
gem "redis-search"
gem 'redis-namespace'

# Background Jobs
gem "resque", :require => "resque/server"

# 设置
gem 'settingslogic'


# ___
gem 'nokogiri'
gem 'mechanize'