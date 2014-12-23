namespace :redis do
  %w[start stop restart].each do |command|
    desc "#{command} redis"
    task command do
      on roles(:app) do
        execute "service redis-server #{command}"
      end
    end
  end
end