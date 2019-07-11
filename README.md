# Welcome to agenda sample

This is a test platform that exposes the **CRUD** for an agenda of contacts and activities in the **Json API** format.

## Resources
- Contact Definition
  >First Name (String)
  >Last Name (String)
  >Cell Phone (String)
  >Zip Code (Number)

- Activity Contact
  >Contact ID (Number)
  >Description (String)

## Endpoints:

|         |Contacts      |Activities                          |                          
|---------|--------------|------------------------------------| 
|`GET`    |/contacts/    |/contacts/:contact_id/activities    |
|`GET`    |/contacts/:id |                                    |
|`POST`   |/contacts/    |/contacts/:contact_id/activities    |
|`PUT`    |/contacts/:id |/contacts/:contact_id/activities/:id|
|`DELETE` |/contacts/:id |/contacts/:contact_id/activities/:id|


* Ruby 2.4.1, Rails 5.2

* This application is configured to run with Postgresql but you can change the database adapter for your convenience.

### Running
* Prepare
   ```bash
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec rake db:seed
  ```

* Run
   ```bash
    $ bundle exec rails s
  ```

* Test
  ```bash
    $ bundle exec rspec
    $ bundle exec rubocop
  ```

* You can play with [Postman](https://www.getpostman.com), docs for endpoints is [here](https://documenter.getpostman.com/view/2705725/SVSGPB2M?version=latest)
