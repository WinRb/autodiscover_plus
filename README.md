# AutodiscoverPlus

A *someday* replacement for the **autodiscover** gem.

## Usage

```ruby
client = AutodiscoverPlus::Client.new(email: "test@example.local", password: "secretpassword")
resp = client.autodiscover
resp.exchange_version
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/autodiscover_plus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
