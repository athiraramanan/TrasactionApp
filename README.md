# README
This is an api application to list the latest measurements available in the history and also posible to list the measurement in a given interval.

Prerequisites
=============
The setups steps expect following to be installed on the system.

	* Ruby Version
		- ruby-2.7.4
	* Rails Version
		- Rails 6.1.4
1.  Install the required gems using
    ######  bundle install
2. Create database.yml file Copy the sample database.yml file and edit the database configuration as required.
    ######  cp config/database.yml.sample config/database.yml
3. Run the following commands to create and setup the database.
    ######		rake db:prepare	
4. You can start the rails server using the command given below.
    ######  rails s
5. API Documentation using Rswag
    ###### Updated the gemfile with below mentioned gems
		gem 'rswag-api'
		gem 'rswag-ui'
		group :development, :test do
		  gem 'rspec-rails'
		  gem 'rswag-specs'
		end
	###### Run the install generator
		rails g rswag:install
	    *************OR******************
		rails g rswag:api:install
		rails g rswag:ui:install
		RAILS_ENV=test rails g rswag:specs:install
    ###### Create the spec based on our controller
		rails generate rspec:swagger Api::V1::MeasurementsController
	###### Generate the Swagger JSON file(s)
		rake rswag:specs:swaggerize
		To run again
			RAILS_ENV=test rails rswag
	###### Spin up our app and check out the URL 
		http://localhost:3000/api-docs
6. To Test your code coverage
	Add the below mentioned gem in our gemfile and bundle
	###### gem "rubycritic", require: false
	###### $ bundle
	Running rubycritic with no arguments will analyse all the Ruby files in the current directory:
	###### $ rubycritic
7.To prepare ERD diagram
	Add the below mentioned gem in our gemfile and bundle
		```
			group :development do
	 		 gem 'rails-erd'
			end
			$ sudo apt-get install graphviz
		```
		It's as simple as a ```bundle exec rake erd``` and it will generate a PDF file in the root of the app.
### Docker Setup
###### If permission issue -> run as sudo
1. Build and Run container:
	###### $ docker-compose build
    ###### $ docker-compose up -d
    -d will run the containers in the background
2. Check container status:
    ###### $ docker-compose ps
    ###### $ docker-compose ps -a 
    will list status of containers that exited with error
3. Create DB:
    ###### $ docker-compose exec web bundle exec rake db:create
    Run migrations:
    ###### $ docker-compose exec web bundle exec rake db:migrate
    Run seed files
    ###### $ docker-compose exec web bundle exec rake db:seed
4. Check container logs:
    ###### $ docker-compose logs
5. Stop container:
    ###### $ docker-compose down
6. Rails console:
    ###### $ docker-compose exec web bundle exec rails c
7. Delete all containers:
    ###### $ ```docker rm -f $(docker ps -a -q)```
In almost all cases ```docker-compose down```  removes the containers. Use the above command to cross-verify.

8. Delete all volumes:
###### $ docker volume rm $(docker volume ls -q)
	And now you can visit the site with the URL http://localhost:3000
9. To Setup the ERD diagram 

###### $ sudo docker-compose exec web bundle install

###### $ sudo docker-compose exec web sudo apt-get install graphviz

###### $ sudo docker-compose exec web bundle exec rake erd
#### Git Related Commands
		git init 
		git add .
		git checkout -b development
		git commit -m "Initial Commit"
		git push origin development
#### References

1.Swagger Documentation
		https://github.com/rswag/rswag

2.Code Coverage
		https://github.com/whitesmith/rubycritic

3.Docker Setup
	
	Docker, Docker Compose, Dockerize the app    
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04

https://www.digitalocean.com/community/tutorials/containerizing-a-ruby-on-rails-application-for-development-with-docker-compose

