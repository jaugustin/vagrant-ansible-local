# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-ansible-local/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-ansible-local"
  spec.version       = Vagrant::AnsibleLocal::VERSION
  spec.authors       = ["jaugustin"]
  spec.email         = ["jeremie.augustin@pixel-cookers.com"]
  spec.description   = %q{"vagrant plugin to provision VM with ansible in local mode"}
  spec.summary       = %q{"vagrant plugin to provision VM with ansible in local mode"}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
