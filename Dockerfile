FROM ruby:2.7.2-alpine3.13

ENV RAILS_ENV=production
ENV NODE_ENV=production

RUN mkdir /iaderdor
WORKDIR /iaderdor

ADD Gemfile Gemfile.lock package.json yarn.lock /
RUN apk update && \
    apk add --no-cache nodejs npm build-base postgresql-dev python2 && \
    apk add --no-cache --virtual .gyp make g++  && \
    gem install bundler && \
    bundle config set no-cache 'true' &&\
    bundle config set without 'development test staging' && \
    bundle install && \
    npm install -g yarn && \
    yarn install --production

ADD . .
RUN bin/rails webpacker:compile && \
    apk del build-base .gyp python2 make g++ && \
    rm -rf node_modules tmp/cache vendor/assets spec

CMD ["rails", "server", "-b", "0.0.0.0"]
