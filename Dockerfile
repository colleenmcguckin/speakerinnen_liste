FROM ruby:2.2.3
RUN apt-get update -qq && apt-get install -y build-essential nodejs libpq-dev && mkdir -p /var/app
WORKDIR /var/app
COPY . /var/app/
RUN bundle install
