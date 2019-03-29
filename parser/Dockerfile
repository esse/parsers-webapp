FROM ruby:2.6.2-alpine3.9

# Lock Bundler version that should be used by exporting it to ENV,
# to correctly support Bundler 2 lock files
ENV BUNDLER_VERSION=2.0.1

RUN apk add --update alpine-sdk

WORKDIR /app
RUN gem install bundler -v 2.0.1

ADD Gemfile Gemfile.lock ./
RUN bundle install --without development test

ADD . .

CMD ["bundle", "exec", "ruby", "cli.rb"]
