# Capistrano::Bundler

Bundler for support for Capistrano 3.x

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano', '~> 3.0.0'
    gem 'capistrano-bundler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-bundler

## Usage

Require in `Capfile` to use the default task:

    require 'capistrano/bundler'

The task will run before `deploy:updated` as part of Capistrano's default deploy,
or can be run in isolation with `cap production bundler:install`

Configurable options, shown here with defaults:

    set :bundle_gemfile, -> { release_path.join('Gemfile') }
    set :bundle_dir, -> { shared_path.join('bundle') }
    set :bundle_flags, '--deployment --quiet'
    set :bundle_without, %w{development test}.join(' ')
    set :bundle_binstubs, -> { shared_path.join('bin') }
    set :bundle_roles, :all
    set :bundle_bins, %w(gem rake rails)

By default, the plugin adds `bundle exec` prefix to common executables listed in `bundle_bins` option. You can add any custom executable to this list:

```ruby
set :bundle_bins, fetch(:bundle_bins).push %w(my_new_binary)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
