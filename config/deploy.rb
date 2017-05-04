# config valid only for current version of Capistrano
lock "3.8.0"

set :application, "csp_reports"
set :repo_url, "https://github.com/esetomo/csp_reports.git"

append :linked_files, '.env'
append :linked_dirs, "log", "tmp/pids", "tmp/sockets"

namespace :deploy do
  namespace :db do
    task :migrate do
      on roles(:app) do
        within release_path do
          execute :rake, 'db:migrate'
        end
      end
    end
  end
end

after 'deploy:updating', 'bundler:install'
after 'deploy:updating', 'deploy:db:migrate'
