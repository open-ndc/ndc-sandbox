FROM ruby:2.2.2

WORKDIR /ndc-sandbox  

COPY Gemfile /ndc-sandbox/Gemfile
COPY Gemfile.lock /ndc-sandbox/Gemfile.lock

RUN bundle install

COPY . /ndc-sandbox

# These commands are used to replace the initial database config for docker
RUN rm config/database.yml
RUN rm config/initializers/redis.rb
COPY docker_database.yml config/database.yml
COPY docker_redis.rb config/initializers/redis.rb

ONBUILD RUN rake db:migrate

ONBUILD RUN rake db:fixtures:load[FA]


EXPOSE 9292


CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]
