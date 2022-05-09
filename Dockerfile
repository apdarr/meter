FROM ruby:3.0.4

RUN apt-get update && apt-get install -y nodejs postgresql-client 
WORKDIR /meter
COPY Gemfile /meter/Gemfile
COPY Gemfile.lock /meter/Gemfile.lock
RUN bundle install
COPY . /meter


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["bundle" "exec", "rails", "server", "-b", "0.0.0.0"]

