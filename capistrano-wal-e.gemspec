# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/wal_e/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-wal-e"
  spec.version       = Capistrano::WalE::VERSION
  spec.authors       = ["Ruben Stranders"]
  spec.email         = ["r.stranders@gmail.com"]
  spec.summary       = 'Capistrano tasks for automatic and sensible WAL-E configuration'

  spec.description   = <<-EOF.gsub(/^\s+/, '')
    Capistrano tasks for automatic and sensible WAL-E configuration.

    For more information about WAL-E, please see
    https://github.com/wal-e/wal-e.

    Works *only* with Capistrano 3+.
  EOF
  spec.homepage      = "https://github.com/capistrano-plugins/capistrano-wal-e"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "capistrano", ">= 3.1"
  spec.add_dependency "sshkit", ">= 1.2.0"
end
