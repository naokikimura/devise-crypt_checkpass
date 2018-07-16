
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "devise/crypt_checkpass/version"

Gem::Specification.new do |spec|
  spec.name          = "devise-crypt_checkpass"
  spec.version       = Devise::CryptCheckpass::VERSION
  spec.authors       = ["naokikimura"]
  spec.email         = ["n.kimura.cap@gmail.com"]

  spec.summary       = %q{Devise password encryptor using crypt_checkpass}
  spec.homepage      = "https://github.com/naokikimura/devise-crypt_checkpass"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "devise", "~> 4.4"
  spec.add_runtime_dependency "devise-encryptable", "~> 0.2.0"
  spec.add_runtime_dependency "crypt_checkpass", "~> 4"
  spec.add_runtime_dependency "fiddle", "~> 1.0"
  spec.add_runtime_dependency "openssl", "~> 2.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "activemodel", "~> 5.1"
  spec.add_development_dependency "argon2", "~> 1.1"

end
