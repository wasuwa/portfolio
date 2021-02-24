# バージョン
lock '3.4.0'

# ログの表示
set :application, 'hssb'
set :deploy_to, '/var/www/rails/portfolio'

# pullするリポジトリ
set :repo_url, 'git@github.com:baru-web-production/portfolio.git'

# バージョンが変わっても共通で参照するディレクトリ
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.7.2'

# 利用する公開鍵
set :ssh_options, auth_methods: ['publickey'], keys: ['~/.ssh/portfolio_key.pem']

# プロセス番号を記載したファイル
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイル
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# Unicornを再起動
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
