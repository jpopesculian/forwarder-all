FROM ruby:2.5

RUN gem install bundler

RUN mkdir /src
WORKDIR /src

COPY ./chainable-message ./chainable-message
COPY ./forwarder-host ./forwarder-host
COPY ./forwarder-schema ./forwarder-schema
COPY ./forwarder-models ./forwarder-models
COPY ./sms-component ./sms-component
COPY ./forwarder-app ./forwarder-app
COPY ./twilio-lib-component ./twilio-lib-component
COPY ./server-component ./server-component

WORKDIR forwarder-app

RUN bundle install

CMD ["bundle", "exec", "puma", "config.ru"]
