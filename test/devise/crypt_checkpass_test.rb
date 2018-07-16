require "test_helper"

class Devise::CryptCheckpassTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Devise::CryptCheckpass::VERSION
  end

  def test_that_it_be_accessible
    encryptor = :crypt_checkpass
    assert ::Devise::Encryptable::Encryptors.const_get(encryptor.to_s.classify)
  end

  def test_that_it_be_configurable
    klass = ::Devise::Encryptable::Encryptors::CryptCheckpass
    password = 'foobarbaz'

    klass.configure do |config|
      config.id = 'pbkdf2-sha256'
      config.kwargs = {}
    end
    assert_match /\A\$pbkdf2-sha256\$/, klass.digest(password, nil, nil, nil)

    klass.configure do |config|
      config.id = 'argon2i'
      config.kwargs = {}
    end
    assert_match /\A\$argon2i\$/, klass.digest(password, nil, nil, nil)
  end

  def test_that_it_is_true_when_comparing_an_encrypted_password_against_given_plaintext
    klass = ::Devise::Encryptable::Encryptors::CryptCheckpass
    password = 'foobar'
    pepper = 'baz'

    assert klass.compare(klass.digest(password, nil, nil, pepper), password, nil, nil, pepper)
  end

  def test_that_it_is_false_when_comparing_with_wrong_password
    klass = ::Devise::Encryptable::Encryptors::CryptCheckpass
    password = 'foobar'
    wrong_password = 'quux'

    encrypted_password = klass.digest(password, nil, nil, nil)
    assert !klass.compare(encrypted_password, wrong_password, nil, nil, nil)
  end

  def test_that_it_is_false_when_comparing_with_correct_password_but_wrong_pepper
    klass = ::Devise::Encryptable::Encryptors::CryptCheckpass
    password = 'foobar'
    pepper = 'baz'
    wrong_pepper = 'qux'

    encrypted_password = klass.digest(password, nil, nil, pepper)
    assert !klass.compare(encrypted_password, password, nil, nil, wrong_pepper)
  end
end
