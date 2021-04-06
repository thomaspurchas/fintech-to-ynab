FROM ruby:2.6.6
WORKDIR /app

RUN gem install bundler -v 1.16.1
ADD Gemfile* /app/
RUN bundle check || bundle install --jobs=4 --retry=3

ADD . /app

ENTRYPOINT bundle exec puma -C config/puma.rb
