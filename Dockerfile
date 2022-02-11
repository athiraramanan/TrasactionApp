FROM ruby:2.7.4
RUN apt-get update -qq \
&& apt-get install -y nodejs postgresql-client

ADD . /weather_sensors_api
WORKDIR /weather_sensors_api
RUN bundle install

EXPOSE 3000

CMD ["bash"]