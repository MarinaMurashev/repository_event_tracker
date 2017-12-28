# Repository Event Tracker

This is a Rails + React app that displays responses from the [Github Events API][1], allowing you to specify the user, repository, and event type you are interested in seeing.  For example, I can input user: marinamurashev, repo name: repository_event_tracker (pretty meta, I know), and event type: CreateEvent.

Please see the Github documentation for details about the api, including response limits, event types and rate limiting.

## Getting set up

This app was built with the following versions:

* Rails 5.1
* Ruby 2.4.3
* Node 9.3.0
* Yarn 1.3.2

To get setup with the app, ensure you have all of those dependencies in place, bundle install the gems (pretty vanilla rails setup). You should now be able to run specs.

To run the app on your localhost (development environment), you will want to run `rails s` in one terminal tab, and `./bin/webpack-dev-server --host 127.0.0.1` in another. If that webpack one throws an error, you may have to run `bundle binstubs bundler --force` before it as well.

[1]: https://developer.github.com/v3/activity/events/

