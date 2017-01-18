source 'https://rubygems.org'

# зависим от рельсов 4.2.*
gem 'rails', '~> 4.2.6'

# гем для авторизации пользователей
gem 'devise', '~> 4.1.1'

# гем для перевода сообщений девайса
gem 'devise-i18n'

# гем с русскими форматами (времени и пр.)
gem 'russian'

# гем, интегрирующий bootstrap
gem 'twitter-bootstrap-rails'

gem 'uglifier', '>= 1.3.0'

# для поддержки jquery
gem 'jquery-rails'

# в продакшен сервере heroku этот гем соединяет с базой данных Postgres
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
end

