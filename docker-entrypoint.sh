#!/bin/bash -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /QUAD/tmp/pids/server.pid

# Add this line before the exec command
export PATH="$PATH:/QUAD/bin"

# If running the rails server then create or migrate existing database
if [ "${1}" == "./bin/rails" ] && [ "${2}" == "server" ]; then
  echo "Preparing database..."
  bundle exec rails db:prepare
  echo "Database prepared."
fi

exec "${@}"
