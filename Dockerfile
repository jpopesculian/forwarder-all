FROM ruby:2.5

RUN gem install bundler
RUN gem install rake

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

RUN cd ./forwarder-app && bundle install
RUN cd ./forwarder-models && bundle install

COPY ./settings ./settings
RUN rm -rf forwarder-app/settings && ln -s /src/settings forwarder-app/settings
RUN rm -rf forwarder-models/settings && ln -s /src/settings forwarder-models/settings

COPY ./start ./start

EXPOSE 9292
CMD ["./start"]
