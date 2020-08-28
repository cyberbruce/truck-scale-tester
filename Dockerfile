FROM ruby:2.7

WORKDIR /app
ADD . /app

ENTRYPOINT ruby main.rb