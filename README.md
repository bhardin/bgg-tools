# bggtools.com

[![Build Status](https://travis-ci.org/bhardin/bgg-tools.svg?branch=master)](https://travis-ci.org/bhardin/bgg-tools) [![Coverage Status](https://coveralls.io/repos/bhardin/bgg-tools/badge.png)](https://coveralls.io/r/bhardin/bgg-tools)

Source code for bggtools.com.

## TO-DO

* [ ] Update Jquery on page, rather than refresh
* [ ] Capistrano: Unicorn
* [ ] Capistrano: Sidekiq
* [ ] Get tests working on Travis

## Running Locally

* Start applicaiton: `rails s`
* Start workers: `sidekiq`

## Deleting all jobs from the Queue:

* Reset Job queue: `Sidekiq::Queue.new.clear`
* Reset Retry queue: `Sidekiq::RetrySet.new.clear`
* Reset processed/failed stats: `Sidekiq::Stats.new.reset`
* Reset dead stats: `Sidekiq::DeadSet.new.clear`

## Deploying to Production

`cap production deploy`

When deploying, you have to log into the server and kill off the old unicorn process. I have no idea why this is.
