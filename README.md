# Capistrano::Bundler

Bundler specific tasks for Capistrano v3:

   * cap production bundler:install

It also prefixes certain binaries to use `bundle exec`.

## Installation

Add these lines to your application's Gemfile:

    gem 'capistrano', '~> 3.1'
    gem 'capistrano-bundler', '~> 1.1.3'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-bundler

## Usage

Require in `Capfile` to use the default task:

    require 'capistrano/bundler'

The task will run before `deploy:updated` as part of Capistrano's default deploy, or can be run in isolation with `cap production bundler:install`

By default, the plugin adds `bundle exec` prefix to common executables listed in `bundle_bins` option. This currently applies for `gem`, `rake` and `rails`.

You can add any custom executable to this list:
```ruby
set :bundle_bins, fetch(:bundle_bins, []).push(:my_new_binary)
```

Configurable options:

    set :bundle_roles, :all                                  # this is default
    set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
    set :bundle_binstubs, -> { shared_path.join('bin') }     # this is default
    set :bundle_gemfile, -> { release_path.join('MyGemfile') } # default: nil
    set :bundle_path, -> { shared_path.join('bundle') }      # this is default
    set :bundle_without, %w{development test}.join(' ')      # this is default
    set :bundle_flags, '--deployment --quiet'                # this is default
    set :bundle_env_variables, {}                    # this is default

You can parallelize the installation of gems with bundler's jobs feature.
Choose a number less or equal than the number of cores your server.

    set :bundle_jobs, 4 #This is only available for bundler 1.4+

This would execute the following bundle command on all servers
(actual paths depend on the real deploy directory):

    bundle install \
      --binstubs /my_app/shared/bin \
      --gemfile /my_app/releases/20130623094732/MyGemfile \
      --path /my_app/shared/bundle \
      --without development test \
      --deployment --quiet

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
