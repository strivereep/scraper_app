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

## TESTING
- `rspec spec/requests/` -- it will run rspec for all the controllers specs
- `rspec spec/lib/` -- it will run rspec for all the helper specs
