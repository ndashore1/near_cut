# README

# Coding challenge

## Dependencies
* Ruby version : 3.0.0
* Rails Version : 6.1.4
* Yarn Version : 1.22.11
* Node Version : 10.19.0

## Configuration
```gem install bundler && bundle install```

```yarn install```
## Setup and Start the Applicaton
### Database Setup
```rake db:create && rake db:migrate```
### Run the rails server
```rails s```
## Test Environment Setup
### Test Database Setup
```RAILS_ENV=test rake db:migrate```
### Run the Test Suit
```rspec```

## Feature Enhancement
```
* Using internationalisation gem I18n for translating application to a single custom language.
* Can use sidekiq for uploading large CSVs
* Password can be more strong with other rules applied to it
* Maintain git history
```
