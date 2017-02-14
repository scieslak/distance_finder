[![Build Status](https://travis-ci.org/scieslak/distance_finder.svg?branch=master)](https://travis-ci.org/scieslak/distance_finder) [![Code Climate](https://lima.codeclimate.com/github/scieslak/distance_finder/badges/gpa.svg)](https://lima.codeclimate.com/github/scieslak/distance_finder)

# DistanceFinder

Welcome to DistanceFinder. Get distance and travel time between almost any two places on the globe.DistanceFinder uses powerful Google API to deliver reliable results fast and without unnecessary baggage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'distance_finder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install distance_finder

## Usage

### Command Line###

After succesfull instalation execute

    $ distance_finder

Possible input formats:

    [TOWN]
    [STREET] [TOWN]
    [HOUSE NUMBER] [STREET] [TOWN,
    [HOUSE NUMBER] [STREET] [TOWN] [COUNTRY]
    [HOUSE NUMBER] [STREET] [TOWN] [COUNTRY] [POST CODE]
    [STREET] [TOWN] [COUNTRY] [POST CODE]
    [TOWN] [COUNTRY] [POST CODE]
    [COUNTRY] [POST CODE]
    [POST CODE]

    `quit` for exit
  
  
### As dependency ###

TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/distance_finder.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

