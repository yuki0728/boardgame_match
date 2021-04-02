# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

# Capistranoのログの表示に利用する
set :application, 'boardgame_match'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, 'git@github.com:yuki0728/boardgame_match'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_files, %w{config/master.key}
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :rbenv_type, :user
set :rbenv_ruby, '2.6.6'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/boardgame_match.pem']

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do

    end
  end

  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'upload master.key'
  task :upload do
    desc 'Create database'
    task :db_create do
      on roles(:db) do |host|
        with rails_env: fetch(:rails_env) do
          within current_path do
            execute :bundle, :exec, :rake, 'db:create'
          end
        end
      end
    end

    on roles(:app) do |_host|
      execute "mkdir -p #{shared_path}/config" if test "[ ! -d #{shared_path}/config ]"
      # upload!('config/master.key', "#{shared_path}/config/master.key")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end
