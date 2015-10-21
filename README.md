# Publications Portal API [![Build Status](https://travis-ci.org/natyconnor/pubs-portal-api.svg?branch=master)](https://travis-ci.org/natyconnor/pubs-portal-api)

This is the API for JoyPact's Publications Portal. Before doing the usual setup, you need to set up your postgres settings. You need a postgres user (i.e. role) with the username `joypact` and it's password is what JOY stands for. (Ask if you don't know). pgAdmin makes creating users easy. Make sure this user can create database ojects.

For security reasons, these are not hardcoded into the database.yml, but need to be stored in environment variables. The `application.rb` is set up to look for a file `config/local_env.yml` with these environment variables. You will need `DATABASE_USERNAME` and `DATABASE_PASSWORD`. Now you can do the usual setup:

```
$ bundle install
$ rake db:setup
```

Heroku is already set up with these if we ever need them.

That should get you set up with the basic development data. If developing the [front-end](https://github.com/natyconnor/pubs-portal-front-end), be sure to follow it's setup and copy the necessary files from this repo in order to maintain parity for the database.
