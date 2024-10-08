# Internet Game Database Client

A Ruby client for the [Internet Game Database](https://www.igdb.com/)

## Installation

## Pre-requisites
See the [IGDB Getting Started Guide](https://api-docs.igdb.com/#getting-started).  You'll need:
1. A Twitch account w/2FA
1. A registered twitch application in the developer portal
1. A client id for the application
1. A client secret for the application

### Bundler

Add the gem to your Gemfile:

```ruby
gem 'igdb_client', git: 'git@github.com:kmagameguy/igdb_client'
```

And then run:

```bash
bundle install
```
### Setup .ENV

Replace the template values in the provided `.env` file with your own values.  You can also set secrets for different environments with multiple `.env` files.  For example, for a rails app in development mode, use `.env.development.local`.

See the [dotenv](https://github.com/bkeepers/dotenv) documentation for more details.

### Run Setup Script
Run `bin/setup` to finish installation.  This script just checks the current environment and performs tasks like installing bundler and the required gems (see `igdb_client.gemspec` and `Gemfile` for more details).

## Usage Instructions

Use the provided `bin/console` script to open a ruby interpreter session with the IGDB Client pre-loaded.  At the simplest level, usage works like this:

```ruby
client = IgdbClient::Api.new
client.get(:games)
=> # Returns an array of 10 games, where each game is represented by an OpenStruct object.  ALL available fields are returned.
```

Each endpoint is represented as a symbol.  To see the available endpoints, run this:

```ruby
IgdbClient::Api.help

# or

client = IgdbClient::Api.new
client.help
```

You can also pass query parameters to the `.get` method:

```ruby
client = IgdbClient::Api.new
client.get(:games, fields: "name")
=> # Returns 10 games with only their ID and name fields.
```

Pass multiple query parameters with a comma-separated string:

```ruby
client = IgdbClient::Api.new
client.get(:games, fields: "name,aggregated_rating,hypes")
=> # Returns 10 games with only their ID, name, aggregated_rating, and hypes.
```

Alternatively you can exclude specific fields with a comma-separated string:

```ruby
client = IgdbClient::Api.new
client.get(:games, exclude: "screenshots,websites")
=> # Returns 10 games with all fields EXCEPT the 'screenshots' and 'websites' fields
```

You can specify expanded attributes for associated fields with dot-notation (`.`):
```ruby
client = IgdbClient::Api.new
client.get(:games, fields: "name, platforms.*")
=> # Returns 10 games with only their ID, name, and platforms field, where the platforms response includes ALL platforms data, not just the platform ID

client.get(:games, fields: "name, platforms.name")
=> # Returns 10 games with only their ID, name, and the ID + Name of each platform the game supports"
```

You can also retrieve information for specific items by passing an `id` value:
```ruby
client = IgdbClient::Api.new
client.get(:games, id: 124961)
=> # Returns the game whose ID matches the one specified.  Includes all available fields.
```

You can find multiple items by supplying multiple `id` values in an array:
```ruby
client = IgdbClient::Api.new
client.get(:games, id: [124961, 5])
=> # Returns an array of OpenStructs for each found ID.  If an ID is not found it will simply be skipped.  Includees all available fields.

You can pass `id` & `fields` parameters together:
```ruby
client = IgdbClient::Api.new
client.get(:games, id: 124961, fields: "name" )
=> # Returns the specified game and only its ID and Name fields.
```

You can search for content by passing a `search` value:
```ruby
client = IgdbClient::Api.new
client.get(:characters, search: "Bob", fields: "name")
```

You can limit the number of retrieved items with the `limit` value:
```ruby
client = IgdbClient::Api.new
client.get(:games, fields: "name", limit: 3)
```

You can offset the results, too:
```ruby
client = IgdbClient::Api.new
client.get(:games, fields: "name", limit: 3, offset: 7)
```

This example skips over the first 7 results and returns the next 3.

You can order the results by field and direction:
```ruby
client = IgdbClient::Api.new
client.get(:games, limit: 15, search: "Super", sort_by: "aggregated_rating", sort_direction: :desc)
```

Note that the `sort_direction` parameter is optional.  When not specified the default sort order is `:asc` (ascending).

The client accepts advanced filtering as defined by the IGDB API:
```ruby
client = IgdbClient::Api.new
client.get(:games, fields: "name", filter: "where rating >= 80")
```

See the [IGDB API Documentation for filters](https://api-docs.igdb.com/#filters) for more information.  The client does not currently perform any validations against the filter query.

### Other Notes
As long as you hold a reference to the `IgdbClient::Api` in memory, it will manage authentication concerns w/Twitch automatically.
The access token remains in memory until it expires at which point any subsequent request made through the client will silently reauthenticate and process the request.

## Development
Contributions are welcome.  To get started with development:
1. Fork this repository.
1. Complete the setup steps above.
1. Make a pull request when you're ready to propose changes.
1. Include test coverage for your changes.  You can run `bin/test` to run the test suite.
