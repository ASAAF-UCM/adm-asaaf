FROM ruby:2.7.2-alpine3.13 AS build-env

ARG RAILS_ROOT=/admasaaf

ENV RAILS_ENV=production
ENV NODE_ENV=production

WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock package.json yarn.lock /admasaaf/

RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs npm build-base postgresql-dev python2 && \
    apk add --no-cache --virtual .gyp make g++ && \
    gem update bundler

RUN BUNDLE_APP_CONFIG=.bundle && \
    bundle _2.2.14_ && \
    bundle config --local set no-cache 'true' && \
    bundle config --local set without 'development test staging' && \
    bundle config --local deployment true && \
    bundle config --local path vendor/bundle && \
    bundle install --jobs=4 && \
    npm install -g yarn && \
    yarn install --production

COPY . .

RUN bundle exec rails webpacker:compile

RUN rm -rf node_modules tmp/cache vendor/assets spec

FROM ruby:2.7.2-alpine3.13
ARG RAILS_ROOT=/admasaaf

WORKDIR $RAILS_ROOT

COPY --from=build-env $RAILS_ROOT $RAILS_ROOT

RUN BUNDLE_APP_CONFIG=.bundle && \
    rm .bundle/config &&\
    mv bundle/config .bundle/


RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache tzdata postgresql-dev nodejs bash


CMD bundle exec rails server -b 0.0.0.0
