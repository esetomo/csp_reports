# config valid only for current version of Capistrano
lock "3.8.0"

set :application, "csp_reports"
set :repo_url, "https://github.com/esetomo/csp_reports.git"

append :linked_dirs, "log", "tmp/pids", "tmp/sockets"
