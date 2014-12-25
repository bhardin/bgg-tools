# bggtools.com

Source code for bggtools.com.

## TO-DO

* [ ] Update Jquery on page, rather than refresh
* [ ] Migrate dev environment to MySQL
* [ ] Move Update User to a background worker
* [ ] Add Link to Paypal donations
* [ ] Capistrano: Unicorn
* [ ] Capistrano: Sidekiq

## Running Locally

* Start applicaiton: `rails s`
* Start workers: `sidekiq`

## Deleting all jobs from the Queue:

* Reset Job queue: `Sidekiq::Queue.new.clear`
* Reset Retry queue: `Sidekiq::RetrySet.new.clear`
* Reset Processed/Failed: `Sidekiq::Stats.new.reset`

## Deploying to Production

`cap production deploy`
