# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/var/www/bgg-tools"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/var/www/bgg-tools/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/var/www/bgg-tools/log/unicorn.log"
stdout_path "/var/www/bgg-tools/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.bgg-tools.sock"
listen "/tmp/unicorn.bgg-tools.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30