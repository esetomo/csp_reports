# coding: utf-8
require 'bundler'
Bundler.require

Dotenv.load!

namespace :db do
  task :migrate do
    exec "bundle exec sequel -m db/migrate #{ENV['DBURL']}"
  end
end
