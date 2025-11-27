# Internet Game Database Client Changelog
# 2.7.0
- Potentially Breaking Change: Enforce minimum ruby version of 2.6.  This was the minimum version we were already testing against, this change just makes the support cutoff clear/official.
- Adds rubocop config for development
- Addresses existing rubocop violations

# 2.6.3
- Adds support for remaining endpoints that were missing
- Raises a deprecation warning when using a deprecated endpoint

# 2.6.2
- Add `game_status` endpoint

# 2.6.1
- Support ruby 3.4.7
- Add `game_type` endpoint

## 2.6.0
- Support ruby 3.3.6
- Make OpenStruct an explicit dependency

## 2.5.0
- Support advanced filtering:
```ruby
IgdbClient::Api.new.get(:games, fields: "name", filter: "where rating >= 80")
```

See the official [IGDB#filters](https://api-docs.igdb.com/#filters) documentation for more details.

## 2.4.0
- Support pagination feature with `offset` field:

```ruby
IgdbClient::Api.new.get(:games, limit: 15, offset: 20)
```

This returns the first 15 results after the first 20.

## 2.3.0
- Support sorting returned lists by property and direction.  For example:

```ruby
IgdbClient::Api.new.get(:games, limit: 15, search: "Super", sort_by: "aggregated_rating", sort_direction: :desc)
```

This returns up to 15 games whose search result matches "Super", and sorts them in descending order by their `aggregated_rating`.  Note that if `sort_direction` is not specified then sorting defaults to `ascending`.

## 2.2.1
- Refactor Query::Builder class (no user-facing changes)

## 2.2.0
- Support querying fields with a comma-separated exclusion list.  For example:

```ruby
IgdbClient::Api.new.get(:games, exclude: "screenshots,websites")
```

This returns all fields _except_ the screenshots and websites arrays.

## 2.1.0
- Support searching for multiple IDs in a single query.  For example:

```ruby
IgdbClient::Api.new.get(:games, id: [1103, 5])
```

This returns an array of OpenStructs for each entry found.  Any IDs not found will simply be dropped.

## 2.0.1
- Fix incorrect version file

## 2.0.0
- BREAKING: Return `item` instead of `[item]` when an ID number is part of the `:get` request.
- BREAKING: Return `item` instead of `[item]` when a `limit` of `1` is specified as part of the `:get` request.

## 1.0.1
- Fix a regression in which access tokens were being renewed with every request instead of on expiration.

## 1.0.0
- BREAKING: Rename `IgdbClient::ApiClient` to `IgdbClient::Api`.
- BREAKING: Use keyword arguments for `IgdbClient::Api.new` instead of a hash.
- Extract several utility classes from the core `IgdbClient::Api` class.

## 0.1.0
- Make search queries easier to use.
- Fix a bug with `missing_fields_parameter?` check.

## 0.0.1
Initial Release.
