# Internet Game Database
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
