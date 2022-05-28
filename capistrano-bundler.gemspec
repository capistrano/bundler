# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-bundler'
  spec.version       = '2.1.0'
  spec.license       = 'MIT'
  spec.authors       = ['Tom Clements', 'Lee Hambley', 'Kir Shatrov']
  spec.email         = ['seenmyfate@gmail.com', 'lee.hambley@gmail.com', 'shatrov@me.com']
  spec.description   = %q{Bundler support for Capistrano 3.x}
  spec.summary       = %q{Bundler support for Capistrano 3.x}
  spec.homepage      = 'https://github.com/capistrano/bundler'
  spec.metadata      = {
    "changelog_uri" => "https://github.com/capistrano/bundler/releases"
  }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.1'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'danger'
  spec.add_development_dependency 'rake'
end
