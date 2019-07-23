# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
 Git
========

=>git config --global user.name "Your Name"
=>git config --global user.email your.email@example.com
=>git init
=>git add .
=>git status
=>git commit -m "Initialize repository"
=>git push -u origin master

Heroku
=======

1. Database.yml
2. production.rb
3. Add pg to Gemfile
4. Bundle install
5. Add to Git ( git init,git add -A, git commit -m "Chatapp",git push origin master )
6. Create heroku application
7. Heroku login -i or heroku login
8. heroku git:remote -a your_app_name
9. Add to Git ( git init,git add -A, git commit -m "Chatapp",git push origin master )
10. git push heroku master
11. heroku run rails db:migrate

[Heroku: PG::ConnectionBad: could not connect to server: Connection refused]
============================================================================

https://devcenter.heroku.com/articles/heroku-postgresql#designating-a-primary-database
https://stackoverflow.com/questions/32815705/heroku-pgconnectionbad-could-not-connect-to-server-connection-refused/32815724#32815724

- heroku pg:info
- 1) heroku addons:create heroku-postgresql
- 2) heroku config --app your_app_name
- 3) heroku run rails db:migrate
