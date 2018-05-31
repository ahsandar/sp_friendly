# README

* `Ruby` version used `2.5.1`

* `Rails` version used `5.2.0`

* System dependencies
  - `docker`
  - `docker-compose`


* Database creation

   - `docker-compose run app rails db:create`


* Database initialization

  -  `docker-compose run app rails db:migrate`


* How to run the test suite

  -  `docker-compose run app rails test`


* Deployment instructions

 - `docker-compose up`


To run the app execute command in following order

```
docker-compose run app rails db:create
docker-compose run app rails db:migrate
docker-compose up
```


* Documentation

  - Run the app and visit http://localhost:3000/docs

  
