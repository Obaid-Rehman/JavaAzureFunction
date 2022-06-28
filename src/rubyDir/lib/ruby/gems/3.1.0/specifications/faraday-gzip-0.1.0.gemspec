# -*- encoding: utf-8 -*-
# stub: faraday-gzip 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "faraday-gzip".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/bodrovis/faraday-gzip/issues", "changelog_uri" => "https://github.com/bodrovis/faraday-gzip/blob/master/CHANGELOG.md", "documentation_uri" => "http://www.rubydoc.info/gems/faraday-gzip/0.1.0", "homepage_uri" => "https://github.com/bodrovis/faraday-gzip", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/bodrovis/faraday-gzip" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ilya Bodrov-Krukowski".freeze]
  s.date = "2022-02-04"
  s.description = "Faraday plugin to automatically set compression headers (GZip, Deflate, Brotli) and decompress the response.\n".freeze
  s.email = ["golosizpru@gmail.com".freeze]
  s.homepage = "https://github.com/bodrovis/faraday-gzip".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new([">= 2.6".freeze, "< 4".freeze])
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Automatically sets compression headers and decompresses the response".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<faraday>.freeze, [">= 1.0"])
    s.add_runtime_dependency(%q<zlib>.freeze, ["~> 2.1"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.21.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.25.0"])
    s.add_development_dependency(%q<rubocop-packaging>.freeze, ["~> 0.5.0"])
    s.add_development_dependency(%q<rubocop-performance>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<rubocop-rspec>.freeze, ["~> 2.0"])
  else
    s.add_dependency(%q<faraday>.freeze, [">= 1.0"])
    s.add_dependency(%q<zlib>.freeze, ["~> 2.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.21.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 1.25.0"])
    s.add_dependency(%q<rubocop-packaging>.freeze, ["~> 0.5.0"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 2.0"])
  end
end
