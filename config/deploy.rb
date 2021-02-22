# バージョン
lock '3.4.0'

# ログの表示
set :application, 'hssb'
set :deploy_to, '/var/www/rails/portfolio'

# pullするリポジトリ
set :repo_url, 'git@github.com:baru-web-production/portfolio.git'

# バージョンが変わっても共通で参照するディレクトリ
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :rbenv_type, :user
set :rbenv_ruby, '2.7.2'

# 利用する公開鍵
set :ssh_options, keys: '~/.ssh/portfolio_key_rsa'

# プロセス番号を記載したファイル
set :unicorn_pid, -> { "#{app_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイル
set :unicorn_config_path, -> { "#{app_path}/config/unicorn.rb" }
set :keep_releases, 5

# Unicornを再起動
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
