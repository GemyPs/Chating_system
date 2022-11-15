FROM ruby:2.7.6 as rails-base

ENV APP_HOME /app

RUN gem install rails -v 5.2.6
RUN gem install bundler

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -\
  && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs cron\
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*\
  && npm install -g yarn@1

RUN gem install bundler
WORKDIR $APP_HOME

COPY . .

RUN bundle install
#RUN bundle add puma

EXPOSE 3000

RUN bundle exec whenever --update-crontab
CMD cron && bundle exec puma -C config/puma.rb
