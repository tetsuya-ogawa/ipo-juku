FROM ruby:2.5.1

RUN apt-get update &&\
  apt-get install -y curl emacs-nox task-japanese locales emacs-nox less locales build-essential liblzma-dev patch ruby-dev zlib1g-dev
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN cd /tmp &&\
  curl -O 'https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x64.tar.gz' &&\
  tar zxvf node-v8.9.4-linux-x64.tar.gz &&\
  mv node-v8.9.4-linux-x64 /usr/local/node_home
ENV PATH $PATH:/usr/local/node_home/bin
RUN npm install yarn -g

RUN mkdir -p /rails_app
WORKDIR /rails_app
COPY Gemfile Gemfile.lock /rails_app/
RUN bundle install --path .bundle --without test
COPY package.json yarn.lock .postcssrc.yml /rails_app/
RUN yarn install

COPY Rakefile .postcssrc.yml .babelrc .env /rails_app/
COPY config /rails_app/config
COPY bin /rails_app/bin
COPY app/assets /rails_app/app/assets
COPY app/javascript /rails_app/app/javascript
RUN bundle exec rails assets:precompile --trace

ADD . /rails_app

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-e", "production", "-C", "config/puma.rb"]
