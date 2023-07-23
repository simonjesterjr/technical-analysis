Gem::Specification.new do |spec|
  spec.name          = "technical-analysis"
  spec.version       = "0.3.0"
  spec.authors       = ["Intrinio and Sawtooth Trading"]
  spec.email         = ["admin@intrinio.com"]
  spec.description   = %q{A Ruby library for performing technical analysis on stock prices and other data sets.}
  spec.summary       = %q{A Ruby library for performing technical analysis on stock prices and other data sets.}
  spec.homepage      = "https://github.com/simonjesterjr/technical-analysis"
  spec.files         = Dir["{spec,lib}/**/*.*"]
  spec.require_path  = "lib"
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.add_development_dependency "bundler", "~> 2.3.26"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9.20"
end
