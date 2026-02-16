# keydown

TODO: Write a description here

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     keydown:
       github: M1sui/KeyDownEvent-cr
   ```

2. Run `shards` or `shards instal`

## Usage

```crystal
require "keydown"
key=Key.new(debug: false)
key.keyDown{|keyName,vid|
	puts keyName
	puts vid
}

key.run
```

## Contributing

1. Fork it (<https://github.com/your-github-user/keydown/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [InstanceMethod](https://github.com/M1sui)(X: [Instance_VRC](https://x.com/Instance_VRC)) - creator and maintainer
