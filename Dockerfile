# syntax=docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim as base

# Set the working directory inside the container to match the docker-compose volume
WORKDIR /quad

# Set environment variables for development
ENV RAILS_ENV=development \
    RACK_ENV=development \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=""

# Update and install dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev curl libvips42 postgresql-client git && \
    rm -rf /var/lib/apt/lists/* 

# Install Yarn (optional, remove if not using Webpacker or Yarn packages)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the main application
COPY . .

# Add a script to be executed every time the container starts
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make the script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint to use the script
ENTRYPOINT ["docker-entrypoint.sh"]


# Expose the port the server runs on
EXPOSE 3000

# Start the Rails app
CMD ["rails", "server", "-b", "0.0.0.0"]
