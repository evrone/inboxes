# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "inboxes/version"

Gem::Specification.new do |s|
  s.name        = "inboxes"
  s.version     = Inboxes::VERSION
  s.authors     = ["Kir Shatrov"]
  s.email       = ["razor.psp@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Messaging system for Rails 3 app}
  s.description = %q{Messaging system for Rails 3 app}

  s.rubyforge_project = "inboxes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "ruby-debug"
  # s.add_runtime_dependency "rest-client"
end
