# README

### Setup and Installation
* Clone the repository
* Run bundle and install dependencies
* Run `bundle exec rails db:setup` to set up your database and seed it with providers

### Running the App
* To run this locally you will need to expose a local web servier to the internet. Setup ngrok (or a similar service) to expose port 3000 (or whatever port you run your rails server on locally)
* You can set your APP_DOMAIN on the command line when you launch your server: `APP_DOMAIN=yourdomain.ngrok.io bundle exec rails s`
  * Alternatively, you can set your APP_DOMAIN in a `.env` file and then start your server: `bundle exec rails s`
  * Note: just include the domain like in the example above, ignore any prefixes like `https://`
* Use Postman or another tool to send POST requests to /api/v1/messages

### Sending Requests
* Requests should contain:
  * `recipient`: string
  * `content`: string
* Simulate invalid requests with recipients that start with `3` or `4`

### Testing
* Run tests with `bundle exec rails test`
