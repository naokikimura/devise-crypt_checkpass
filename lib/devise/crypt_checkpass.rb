require "devise"
require "devise-encryptable"
require "devise/crypt_checkpass/version"
require "crypt_checkpass"

module Devise
  module Encryptable
    module Encryptors
      class CryptCheckpass < Base
        class Config
          include ActiveSupport::Configurable
          config_accessor :id, :kwargs
        end

        def self.configure
          yield @config ||= Config.new
        end

        def self.config
          @config
        end

        configure do |config|
          config.id = 'pbkdf2-sha512'
          config.kwargs = {
            rounds: 2048,
          }
        end

        def self.dredge(pepper:, password:)
          [password, pepper].join ''
        end

        def self.digest(password, stretches, salt, pepper)
          crypt_newhash dredge(password: password, pepper: pepper), id: config.id, **config.kwargs
        end

        def self.compare(encrypted_password, password, stretches, salt, pepper)
          crypt_checkpass? dredge(password: password, pepper: pepper), encrypted_password
        end

        private_class_method :dredge
      end
    end
  end
end
