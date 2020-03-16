FROM alpine:3.9.5
RUN apk add --no-cache --update ruby-full ruby-dev build-base \
    && gem install bundler -v 1.17.2

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install
COPY . $APP_HOME

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
