# Gamefic TTY

A Gamefic engine for games that run on IO.

**Features:**

* Works with the `gamefic-standard` library
* Converts Gamefic's default HTML output to ANSI text

**Common uses:**

* Run a game on the command line.
* Attach IO streams to run the game over other processes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gamefic-tty'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gamefic-tty

## Usage

The easiest way to get started with Gamefic TTY is with the Gamefic SDK. See the [SDK README](https://github.com/castwide/gamefic-sdk) for more information.

An example script that runs a game on the command line:

```ruby
require 'gamefic-tty'

Gamefic.script do
  introduction do |actor|
    actor.tell "Hello, world!"
  end
end

Gamefic::Tty::Engine.run
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/castwide/gamefic-tty.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
