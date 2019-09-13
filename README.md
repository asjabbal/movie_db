# README

How to run the app locally:-

- Install ruby-2.6.0 and rails-5.2.2 through rvm or rbenv
- git clone https://github.com/asjabbal/movie_db.git
- cd to app directory and run `bundle install`
- configure config/database.yml accordingly
- run `rake db:drop db:create db:migrate db:seed --trace` (it will take around 5 mins to seed data)
- run app `rails s`
- open http://localhost:3000 in your browser to view app