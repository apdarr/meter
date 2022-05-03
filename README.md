# README

This is a GitHub App intended to capture the usage of certain GitHub Actions. 

This app is not meant to replace GitHub's current billing features, but to provide auxiliary information, especially for the purposes or charge back (also known as bill-back).

As this is an alpha, it is not guaranteed to be stable. The below instructions walk through the steps to build and operate the source code locally.  

# Dependencies 

## Ruby and Rails 
This application was built with Rails 6.1.4 and Ruby 2.6.8. You can view the guide to installing and configuring Rails and Ruby here: https://guides.rubyonrails.org/getting_started.html. 

## PostgreSQL 

The database is a PostgreSQL database. [The Postgres documentation](https://www.postgresql.org/download/) includes links to installing the database based on your platform of of choice. If you're running on macOS, the Postgres.app software is a great choice for installing PostgreSQL. 

## Redis 

`meter` uses background job processing, which depends on Redis. You'll need to install Redis on your machine [and this guide](https://redis.io/docs/getting-started/) walks through this process.

# Building the app

Once you have the requisite Ruby and Rails versions installated on your machine, Postgres, and Redis, you can begin building the app.

## Install the required gems

From the working directory of `meter`, install the required gems with `bundle install`.

## Migrate the database 

In order for Postgres to be aware of the schema, you'll need to run the `rails db:migrate` command from the `meter` directory. The Rails documentation explains this topic and provides further background on the `db:migrate` command: https://guides.rubyonrails.org/active_record_migrations.html.

# Running the app 

## Start Puma 

Rails uses Puma as its web server. Puma is a web server that is designed to be fast and lightweight and is also used in throughput-heavy production workloads. 

In the context of `meter`, Puma will receive incoming webhook requests from GitHub and process them. The `meter` app is configured to run on port 3000.

## Ensure that Postgres is up

The app requires Postgres to be up and running in order to run. If you're running on macOS, you can start Postgres by opening the Postgres.app software. 

## Start Puma 

Start Puma by running `rails server` from the `meter` directory. Once successfully started, the logs should look something like: 

```
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```


## Start Redis 

From a terminal, start Redis: `redis-server`. 

## Start Sidekiq 

In a new tab in the terminal, start Sidekiq: `bundle exec sidekiq`. Sidekiq is a background job processor that is used to process incoming webhooks and save their metadata to the database. It requires and depends on Redis for operation. 

# Configure a webhook 

In order for the application to receive events around Action events, you'll need to configure a webhook [at the org level](https://docs.github.com/en/enterprise-cloud@latest/developers/webhooks-and-events/webhooks/about-webhooks). 

In configuring the payload URL, it should hit the http://1234-abcd-5678.ngrok.io/workflow_runs endpoint. Per this example, you can use something like [ngrok](https://ngrok.com/) to tunnel the webhook payload to your local machine.

The app must listen for the "Workflow runs" event. I don't recommend that you select "Send me everything" as this will create unnecessary noise in the logs and throughput on the `meter` application. 

# Monitor for events 


Once you've built the app, have it running, and configured a webhook, you can monitor the GitHub Actions workflow events that are being sent to the app.

From your browser, navigate to localhost:3000/workflow_runs. Note that the  minutes usage will be displayed in miliseconds, as this is the unit that GitHub's API uses. 


