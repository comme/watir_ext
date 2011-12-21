# -*- coding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "watir_ext/version"

Gem::Specification.new do |s|
  s.name        = "watir_ext"
  s.version     = WatirExt::VERSION
  s.authors     = ["dongyang He"]
  s.email       = ["dd.dongyang@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{a extension packge for watir 1.6.5}
  s.description = %q{fix some bug in watir 1.6.5 like:click_no_wait,each.add some new function to it ,like: ie_version,more detail please see readme. }

  s.rubyforge_project = "watir_ext"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency "watir", '>=1.6.5'
  s.add_dependency "popup"
end
