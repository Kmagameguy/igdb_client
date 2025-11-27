require "pathname"
require_relative "lib/igdb_client/version"

Gem::Specification.new do |spec|
  spec.name          = "igdb_client"
  spec.version       = IgdbClient::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Kmagameguy"]
  spec.description   = "Find game-related information from the Internet Game Database"
  spec.summary       = "A Ruby client for the Internet Game Database"
  spec.homepage      = "https://github.com/kmagameguy/igdb_client"

  spec.files         = Dir.glob(Pathname.new(__dir__).join("lib/**/**")).reject do |file|
    file.match(%r{^(test)/}) || File.directory?(file)
  end

  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activesupport")
  spec.add_dependency("dotenv")
  spec.add_dependency("faraday")
  spec.add_dependency("ostruct")
end
