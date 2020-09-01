FROM ruby:2.5

RUN mkdir /api_test/
WORKDIR /api_test/

COPY Gemfile* /api_test/
RUN bundle install
COPY . /api_test/