# Set the working application directory
APP_PATH = "/var/www/bgg-tools/current"
working_directory APP_PATH

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid APP_PATH + "/tmp/pid/unicorn.pid"

# Path to logs
stderr_path APP_PATH + "/log/unicorn.log"
stdout_path APP_PATH + "/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.bgg-tools.sock"
listen "/tmp/unicorn.bgg-tools.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30