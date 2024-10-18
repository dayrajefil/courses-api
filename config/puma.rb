backend_url = ENV['BACKEND_URL']
host, port = backend_url.gsub('http://', '').split(':')

max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
min_threads_count = ENV.fetch("RAILS_MIN_THREADS", max_threads_count)
threads min_threads_count, max_threads_count

if ENV["RAILS_ENV"] == "production"
  require "concurrent-ruby"
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY", Concurrent.physical_processor_count))
  workers worker_count if worker_count > 1
end

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

bind "tcp://#{host}:#{port}"

environment ENV.fetch("RAILS_ENV", "development")

pidfile ENV.fetch("PIDFILE", "tmp/pids/server.pid")

plugin :tmp_restart
