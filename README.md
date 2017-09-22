# Capistrano::Bundler

Bundler specific tasks for Capistrano v3:

```sh
$ cap production bundler:install
```

It also prefixes certain binaries to use `bundle exec`.

## Installation

Add these lines to your application's Gemfile **[Recommended]**:

```ruby
gem 'capistrano', '~> 3.6'
gem 'capistrano-bundler', '~> 1.3'
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
set :bundle_path, -> { shared_path.join('bundle') }             # this is default. set it to nil for skipping the --path flag.
set :bundle_without, %w{development test}.join(' ')             # this is default
set :bundle_flags, '--deployment --quiet'                       # this is default
set :bundle_env_variables, {}                                   # this is default
set :bundle_clean_options, ""                                   # this is default. Use "--dry-run" if you just want to know what gems would be deleted, without actually deleting them
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

If you want to clean up gems after a successful deploy, add `after 'deploy:published', 'bundler:clean'` to config/deploy.rb.

Downsides to cleaning:

* If a rollback requires rebuilding a Gem with a large compiled binary component, such as Nokogiri, the rollback will take a while.
* In rare cases, if a gem that was used in the previously deployed version was yanked, rollback would entirely fail.

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
