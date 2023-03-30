# Cryptocompare Api
Gem **cryptocompare** Ruby library provides convenient access to the cryptocompare from applications written in the Ruby language. 

See documentation: [API docs](https://min-api.cryptocompare.com/documentation).

## Installation
Add this line to your application's Gemfile:
```ruby
gem 'cryptocompare'
```
And then execute:
```
bundle install
```
## Usage

### Configuration

You can configure the client for each request or confugre factory with defualt values:

```ruby
require 'cryptocompare'
CryptoCompare.configure do |config|
  config.api_key = "YOUR_API_KEY"
  config.pure_hash = true
  ...
end
client = CryptoCompare::Client.get(options) # Options rewrite default values, not require
# or
client = CryptoCompare::Client.new(api_key: "YOUR_API_KEY", options)
```
To get the data, you need to call the method:
```ruby
response = clent.convert(sym: "BTC", tsyms: ["ETH", "UDS"])
```

### Params
* **fsym *string* Required**
The cryptocurrency symbol of interest [ Min length - 1] [ Max length - 30]
* **tsyms *array by string* Required**
Comma separated cryptocurrency symbols list to convert into [ Min length - 1] [ Max length - 500]

### Options
1. **tryConversion *boolean***
If set to false, it will try to get only direct trading values. This parameter is only valid for e=CCCAGG value [ Default - **true**]
2. **relaxedValidation *boolean***
Setting this to true will make sure you don't get an error on non trading pairs, they will just be filtered out of the response. [ Default - **true**]
3. **e *string***
The exchange to obtain data from [ Min length - 2] [ Max length - 30] [ Default - **cccagg_or_exchange**]
4. **extraParams *string***
The name of your application (we recommend you send it) [ Min length - 1] [ Max length - 2000] [ Default - **NotAvailable**]
5. **sign *boolean***
If set to true, the server will sign the requests (by default we don't sign them), this is useful for usage in smart contracts [ Default - **false**]
6. **pure_hash *boolean***
If set to true, the server will return the hash instead of the response (Convert will be throught default JSON.parse) [ Default - **false**]

### Middleware
Gem use a faraday for http request, you can set middleaware, example:
```ruby
response = clent.convert(fsym: "BTC", tsyms: ["ETH", "UDS"]) do |f|
  f.request :json
  f.request :logger
  f.response :json
  f.adapter :net_http
end
```
### Response
If not use flag **pure_hash** response will be object with methods:
1. response.**status** - return **true** if the http request has successful http status
2. response.**body** - return the **pure response** from http client
3. response.**error** - return **pure message** from Cryptocompare if request is not successful

### Strict
Clent can send strict requests, example:
```ruby
response = clent.convert!(fsym: "BTC", tsyms: ["ETH", "UDS"])
```
Raise an error if the http request is not successful.
Error types:
```ruby
# TODO: add all types of errors
CryptoCompare::NotSuccessful #return pure response from CryptoCompare
CryptoCompare::InternalError #unexpected error
```
## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/XaoGao/cryptocompare_api/issues)
- Fix bugs and [submit pull requests](https://github.com/XaoGao/cryptocompare_api/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).