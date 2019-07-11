# Agenda

This is a test platform that exposes the CRUD for an agenda of contacts and activities in the Json API format.

Contact Definition
- First Name (String)
- Last Name (String)
- Cell Phone (String)
- Zip Code (Number)

Activity Contact
- Contact ID (Number)
- Description (String)

Required endpoints:
* Contact
- GET     /contacts/
- GET     /contacts/:id
- POST    /contacts/
- PUT     /contacts/:id
- DELETE

* Activity
- GET     /contacts/:id/activities
- POST    /contacts/:id/activities
- PUT     /contacts/:id/activities/:id
- DELETE

* All fields are mandatory.
* All records must have fields `created_at` y `updated_at`.
* Content type is "application/json"


* Ruby version 2.4.1, Rails version 5.2

* This application is configured to run with Postgresql but you can change the database adapter for your convenience.
bundle install

* Database initialization
bin/rake db:create;
bin/rake db:migrate;
bin/rake db:seed;

* How to run
Finally, start app with
bin/rails s

* How to run the test suite
bin/rspec

* You can play with Postman
docs for endpoints is here
