# Average Cubic Weight Challenge 
Using the provided (paginated) API, find the average cubic weight for all products in the "Air Conditioners" category.

1. Languages Used: Ruby, Html, Js

2. Main Framworks: Rails, Sidekiq, Rspec, Bootsrap

3. Versions Required:
  a. Ruby (2.5.0)
  b. Rails (5.2.0 or above 5.0)
  c. Redis (above 4.0)

4. Database used: Postgres (it's okay to use other DB, such as mySQL, SQLite, please manually configure config/ database.yml to work with other specific DB)

5. Git repo: https://github.com/xuqun123/average_cubic_weight

6. Video Demo: https://www.youtube.com/watch?v=K23qmK4tOOc&feature=youtu.be

7. Setup Instructions:
  a. uncompressed source folder to a working directory
  b. move to the working directory
  c. check ruby, Rails and redis are installed with correct versions
  d. run "bundle install" to install gems
  e. run "rake db:create db:migrate" to create database and migrate needed data
  f. run "bundle exec sidekiq" to run Sidekiq server separately
  g. run "rails s" to startup Rails server
  h. open a browser and visit http://localhost:3000/
    1. enter necessary data to compute cubic weight
    2. click "Request and Calculate" button to activate calculation
    3. the lastest calculation result will be shown in the home page
    4. all fetched products are shown in http://localhost:3000/products
    5. all API request logs are shown in http://localhost:3000/logs
    6. the sidekiq server status can be monitored in http://localhost:3000/sidekiq
  i. run "bundle exec rspec" in command line of the working directory to test controller methods and views. 

8. Solution Explaination 

  a. the first time running the webpage calculation will create a ApiCalculation record, which contains api endpoint used, converison_factor and a category.
  b. then a ApiRequestLog record will be created and send http request to the endpoint. 
  c. those acuired json results will be stored into that ApiRequestLogm, and if any product is found in those results, then create a product and store data (length, width, height, weight) into this Product record
  d. if the results are not returned completely yet (pagination), then create a new ApiRequestLog record with the use of 'next' page endpoint to send next http request.
  e. repeat last operation until there is no more result or API endpoint can be found 
  f. finally, compute the average cubic weight of products through the conversion factor and category that are stored in that ApiCalculation record.

9. Efficient Implementaion on large scales of API requests
  a. when running the calculation operation every time, it actually send the task to a worker of the backend Sidekiq server, which won't influence performance or user experience on web pages.
  b. the calculation setting form and that execution button would be disabled until calculation is finished in backend.
  c. the frontend webpage will be notified once calculation is finished, and then result would be shown up and the form would be unlocked for use.
  d. it might be more obvious to feel and view the effects if using a heavy API endpoint with a large amount of data.


