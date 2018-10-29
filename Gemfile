source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.1'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'bootsnap'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'haml'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'active_decorator'
gem 'ransack'
gem 'kaminari'
gem 'figaro'
gem 'scenic'

gem 'jquery-rails'
gem 'cocoon'

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary', '0.12.3.1' # 0.12.4.0 shrinks text
gem 'pdf-toolkit'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'taiwanese_id_validator'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'time_difference'
  gem 'timecop'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end

group :test do
  gem 'database_rewinder'
  gem 'simplecov', require: false
end
