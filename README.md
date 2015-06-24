# Capistrano::Bundler

Bundler specific tasks for Capistrano v3:

```sh
$ cap production bundler:install
```

It also prefixes certain binaries to use `bundle exec`.

## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.1'
gem 'capistrano-bundler', '~> 1.1.2'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install capistrano-bundler
```

## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano/bundler'
```

The task will run before `deploy:updated` as part of Capistrano's default deploy, or can be run in isolation with `cap production bundler:install`

By default, the plugin adds `bundle exec` prefix to common executables listed in `bundle_bins` option. This currently applies for `gem`, `rake` and `rails`.

You can add any custom executable to this list:
```ruby
set :bundle_bins, fetch(:bundle_bins, []).push('my_new_binary')
```

Configurable options:

```ruby
set :bundle_roles, :all                                         # this is default
set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
set :bundle_binstubs, -> { shared_path.join('bin') }            # default: nil
set :bundle_gemfile, -> { release_path.join('MyGemfile') }      # default: nil
set :bundle_path, -> { shared_path.join('my_special_bundle') }  # default: shared_path.join('vendor/bundle')
set :bundle_without, %w{development test}.join(' ')             # this is default
set :bundle_flags, '--deployment --quiet'                       # this is default
set :bundle_env_variables, {}                                   # this is default
```

You can parallelize the installation of gems with bundler's jobs feature.
Choose a number less or equal than the number of cores your server.

```ruby
set :bundle_jobs, 4 # default: nil, only available for Bundler >= 1.4
```

To generate binstubs on each deploy, set `:bundle_binstubs` path:

```ruby
set :bundle_binstubs, -> { shared_path.join('bin') }
```

Bundler uses `vendor/bundle/` as path for gems if called with `--deployment`.
Therefore this gem adds that path to `linked_dirs`. See the [Bundler
documentation](http://bundler.io/v1.7/man/bundle-install.1.html#DEPLOYMENT-MODE)
for details.

In the result this would execute the following bundle command on all servers
(actual paths depend on the real deploy directory):

```sh
$ bundle install \
  --binstubs /my_app/shared/bin \
  --gemfile /my_app/releases/20130623094732/MyGemfile \
  --path /my_app/shared/bundle \
  --without development test \
  --deployment --quiet
```

If any option is set to `nil` it will be excluded from the final bundle command.

### Environment Variables

The `bundle_env_variables` option can be used to specify any environment variables you want present when running the `bundle` command:

```ruby
# This translates to NOKOGIRI_USE_SYSTEM_LIBRARIES=1 when executed
set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
