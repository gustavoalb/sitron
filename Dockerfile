FROM ruby:2.1.1

#ENV BUNDLER_VERSION="2.2.14"
#ENV DBHOST=10.142.0.12

RUN apt-get update -qq && apt-get install -y build-essential nodejs imagemagick libmagick++-dev libreoffice wkhtmltopdf

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
#COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler -v "~> 1.16"
RUN gem env
COPY . /myapp
RUN bundle install -V

EXPOSE 3000
CMD ["bundle","exec","rails", "server", "-b", "0.0.0.0"]
