FROM ruby:3.1.2-alpine
ENV BUNDLER_VERSION=2.4.19

RUN apk add --update --virtual \
      runtime-deps \
      postgresql-client \
      build-base \
      libxml2-dev \
      libxslt-dev \
      nodejs \
      yarn \
      libffi-dev \
      readline \
      build-base \
      postgresql-dev \
      sqlite-dev \
      libc-dev \
      linux-headers \
      readline-dev \
      file \
      imagemagick \
      git \
      tzdata \
      && rm -rf /var/cache/apk/*

RUN gem install bundler -v 2.4.19
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
COPY package.json yarn.lock ./
RUN yarn install --check-files
COPY . ./
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]

