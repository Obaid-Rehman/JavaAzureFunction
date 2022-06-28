# -*- encoding: utf-8 -*-
# stub: pqapiv2 2021.6.17 ruby lib

Gem::Specification.new do |s|
  s.name = "pqapiv2".freeze
  s.version = "2021.6.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["PayQuicker Support".freeze]
  s.date = "2022-06-28"
  s.description = "desc".freeze
  s.email = "support@payquicker.com".freeze
  s.homepage = "https://www.payquicker.com".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "pqapiv2".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<logging>.freeze, ["~> 2.3"])
    s.add_runtime_dependency(%q<faraday>.freeze, ["~> 2.0", ">= 2.0.1"])
    s.add_runtime_dependency(%q<faraday-follow_redirects>.freeze, ["~> 0.2"])
    s.add_runtime_dependency(%q<faraday-multipart>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<faraday-gzip>.freeze, ["~> 0.1"])
    s.add_runtime_dependency(%q<faraday-retry>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<certifi>.freeze, ["~> 2018.1", ">= 2018.01.18"])
    s.add_runtime_dependency(%q<faraday-http-cache>.freeze, ["~> 2.2"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.14", ">= 5.14.1"])
    s.add_development_dependency(%q<minitest-proveit>.freeze, ["~> 1.0"])
  else
    s.add_dependency(%q<logging>.freeze, ["~> 2.3"])
    s.add_dependency(%q<faraday>.freeze, ["~> 2.0", ">= 2.0.1"])
    s.add_dependency(%q<faraday-follow_redirects>.freeze, ["~> 0.2"])
    s.add_dependency(%q<faraday-multipart>.freeze, ["~> 1.0"])
    s.add_dependency(%q<faraday-gzip>.freeze, ["~> 0.1"])
    s.add_dependency(%q<faraday-retry>.freeze, ["~> 1.0"])
    s.add_dependency(%q<certifi>.freeze, ["~> 2018.1", ">= 2018.01.18"])
    s.add_dependency(%q<faraday-http-cache>.freeze, ["~> 2.2"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.14", ">= 5.14.1"])
    s.add_dependency(%q<minitest-proveit>.freeze, ["~> 1.0"])
  end
end
