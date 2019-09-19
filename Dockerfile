FROM ruby:2.6.0

RUN apt-get update -qq && apt-get install -y build-essential

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /movie_db
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME
RUN bundle install