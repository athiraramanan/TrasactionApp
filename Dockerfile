FROM ruby:2.7.4
RUN apt-get update -qq \
&& apt-get install -y nodejs postgresql-client

ADD . /aza_fin_app
WORKDIR /aza_fin_app
RUN bundle install

EXPOSE 3000

CMD ["bash"]