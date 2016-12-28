FROM rails:4.2.3
WORKDIR /app
ADD . /app/
RUN bundle install
RUN bundle exec rake assets:precompile
