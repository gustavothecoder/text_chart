# TextChart 📊

`TextChart` is a gem that helps you generate text charts, like this one:
```text
 text_chart demonstration
 Show you how cool this is

 73|                                                         ###
   |                                                         ###
 67|             ###             ###                         ###         ###
   |             ###             ###                         ###         ###
 54|     ###     ###     ###     ###                         ### ###     ###
   |     ###     ###     ###     ###                         ### ###     ###
 44|     ### ### ###     ###     ###     ###                 ### ###     ### ###
   |     ### ### ###     ###     ###     ###                 ### ###     ### ###
 33|     ### ### ###     ### ### ###     ###                 ### ###     ### ###
   |     ### ### ###     ### ### ###     ###                 ### ###     ### ###
 27|     ### ### ### ### ### ### ###     ###         ### ### ### ###     ### ###
 20|     ### ### ### ### ### ### ###     ###     ### ### ### ### ### ### ### ###
 14| ### ### ### ### ### ### ### ### ### ###     ### ### ### ### ### ### ### ###
 10| ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
  5| ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
   ----------------------------------------------------------------------------------
```
## Why?

This is a pet project. I like ruby and text-based applications, so I combined them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'text_chart'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install text_chart

## Usage

This snippet will generate the text chart at the top of the readme.
```ruby
TextChart.new(
  "text_chart demonstration",
  "Show you how cool this is",
  [17, 54, 47, 64, 27, 56, 33, 66, 14, 45, 10, 21, 24, 27, 73, 54, 20, 67, 44, 5]
).to_s
```

You can enable colors:
```ruby
TextChart.new(
  "text_chart demonstration",
  "Show you how cool this is",
  [17, 54, 47, 64, 27, 56, 33, 66, 14, 45, 10, 21, 24, 27, 73, 54, 20, 67, 44, 5],
  true
).to_s
```
## Limitations

Right now `TextChart` only supports positive integers.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gustavothecoder/text_chart.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
