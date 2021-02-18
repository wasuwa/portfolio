jobs = 2
timeout = 30
app_dir = "/var/www/rails/portfolio"
listen  = File.expand_path 'tmp/sockets/.unicorn.sock', app_dir
pid = File.expand_path 'tmp/pids/unicorn.pid', app_dir
std_log = File.expand_path 'log/unicorn.log', app_dir
worker_processes  jobs
working_directory app_dir
stderr_path std_log
stdout_path std_log
timeout timeout
listen  listen
pid pid
preload_app true
run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
  if run_once
    run_once = false
  end
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
