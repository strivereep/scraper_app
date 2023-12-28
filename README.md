# README

A simple web scraper app built using React on Rails with specs, that scrapes the content from the given URL like Flipkart and saves the content to the product based on the attributes and associates with the respective categories.

## REQUIREMENTS
- Ruby 3.1.2 (https://www.ruby-lang.org/en/downloads/)
- Node.js (http://nodejs.org/)
- Npm js (https://www.npmjs.com/)
- Redis (https://redis.io/)
- Yarn (https://yarnpkg.com/)
- Ruby on Rails (https://gorails.com/guides)

## INSTALLATION
- Clone repo: `git clone https://github.com/strivereep/scraper_app.git`
- Run `bundle install` -- it will install all the dependencies gems for rails
- Run `yarn install` -- it will install all the necessary frontend packages
- Run `rails db:create`, `rails db:migrate`

## RUNNING
- Run `bin/dev` --  it will start rails server and esbuild
- Run `redis-server` -- it will start redis server
- Run `bundle exec sidekiq` -- it will start the sidekiq for background job processing

## SPECS
- `rspec spec/requests/` -- it will run rspec for all the controllers specs
- `rspec spec/lib/` -- it will run rspec for all the helper specs

## SCHEDULER JOB
- Enabled the scheduler job, that runs every day after 5 minutes of midnight which fetches the attributes for the products that have been scraped 1 week before.
- Please note, this scheduler job runs along with the main threads so it only runs if main server i.e. puma is running.

## SIDEKIQ UI
- `{url}/sidekiq` to see status of all the sidekiq jobs

## SWAGGER API SPECS
- `{url}/api-docs` to see the swagger api docs

## DOCKER
- Run `docker compose up`
- On separate terminal, Run the following commands:
    - `docker container ls`: lists all the containers
    - `docker exec -it {postgres_container_id} /bin/sh`
    - `su - postgres`
    - `psql`
    -  `CREATE USER {username} WITH PASSWORD '{password}';`
    - `CREATE DATABASE {database_name};`
    - `GRANT ALL PRIVILEGES ON DATABASE {database_name} to {username};`
    - `ALTER DATABASE {database_name} OWNER TO {username};`
    - This will create the database with the username and change the owner to the created user.
    - Use the created database, username and password on file `database.yml`
- On separate terminal, Run `docker compose exec app rails db:migrate` to run all the pending migrations.