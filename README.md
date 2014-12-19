# bggtools.com

Source code for bggtools.com.

## TO-DO

[ ] Figure out a way to deploy. (Capistrano?)
[ ] Update Jquery on page, rather than refresh.
[ ] Migrate dev environment to MySQL

## Running Locally

* Start applicaiton: `rails s`
* Start workers: `sidekiq`

## Deleting all jobs from the Queue:

* Job queue: `Sidekiq::Queue.new.clear`
* Retry queue: `Sidekiq::RetrySet.new.clear`
* Sidekiq::Stats.new.reset

## Deploying to Production

`cap deploy:setup`
