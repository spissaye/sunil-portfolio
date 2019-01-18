require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"

namespace :resque do
  task :restart_workers => :environment do
    pids = Array.new

    Resque.workers.each do |worker|
      pids << worker.to_s.split(/:/).second
    end

    if pids.size > 0
      system("kill -QUIT #{pids.join(' ')}")
      system("rm /var/run/god/resque-*.pid")
    end
  end

  task :enqueue, [:job_name] => :environment do |t, args|
    begin
      Resque.enqueue args[:job_name].classify.constantize, Socket.gethostname
    rescue NameError => e

    end
  end
end
