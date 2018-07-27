FROM ruby:2.4.3

MAINTAINER Dmitriy.Rotatii "kvazilife@gmail.com@gmail.com"
ENV S3_KEY ""
ENV S3_PRIVATE_KEY ""
ENV PALLADIUM_TOKEN ""
ENV DOCUMENTSERVER_JWT ""

RUN mkdir ~/.documentserver
RUN echo $DOCUMENTSERVER_JWT > ~/.documentserver/documentserver_jwt

RUN mkdir ~/.palladium
RUN echo $PALLADIUM_TOKEN > ~/.palladium/token

RUN mkdir /convert_service_testing
WORKDIR /convert_service_testing
ADD . /convert_service_testing
RUN bundle install --without test development

