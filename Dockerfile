# Base our image on an official, minimal image of our preferred Ruby
FROM ruby:2.5.1-slim-stretch

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client

# Set our working directory inside the image
# Copy the app's code into the container
ENV APP_HOME /var/app/sp_friendly
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler

# Finish establishing our Ruby enviornment
RUN bundle install

COPY . $APP_HOME

EXPOSE 3000


# Run puma server by default
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]