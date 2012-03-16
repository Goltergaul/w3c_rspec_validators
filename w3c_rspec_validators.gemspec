# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "w3c_rspec_validators/version"

Gem::Specification.new do |s|
  s.name        = "w3c_rspec_validators"
  s.version     = W3cRspecValidators::VERSION
  s.authors     = ["Dominik Goltermann"]
  s.email       = ["dominik@goltermann.cc"]
  s.homepage    = ""
  s.summary     = %q{This gem adds w3c validation in form of rspec matchers}
  s.description = %q{At this time it allows for validation of html (including html5) produced by rspec acceptance tests. In addition you can configure the gem to use a locally installed validation service instead of the online w3c servers}

  s.rubyforge_project = "w3c_rspec_validators"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "w3c_validators"
end
