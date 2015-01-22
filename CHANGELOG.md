# 1.1.4 (22 Jan 2014)

* Don’t generate binstubs by default (#61)

# 1.1.3 (4 Aug 2014)

* Honor `:no_release` flag by using `release_roles` in Capistrano 3.1
* capistrano-bundler now requires Capistrano 3.1 or higher (~> 3.1)
* Added `:bundle_jobs` option for specifying number of parallel jobs

# 1.1.2 (8 Feb 2014)

* Added `bundle_env_variables` option for specifying environment variables that should be set when running `bundle`.
* The `bundle_dir` option is now named `bundle_path`
* Use `bundle install` instead of `bundle`
* All options are now optional and can be excluded from the final bundle command by setting them to `nil`
* Bundler looks for a `Gemfile` by default, so there is no need to specify it.

# 1.1.1

* ruby is not prefixed with `bundle exec` anymore by default
* prefix rails with `bundle exec` by default

# 1.1.0

* Switching to new command map (https://github.com/capistrano/sshkit/pull/45)
  Thanks to new command map, now this integration adds `bundle exec` to global executables (gem, ruby, rake). The list of executable can be tweaked by `bundle_bins`.

# 1.0.0

Initial release
