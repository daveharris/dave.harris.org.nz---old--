class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(username, password)
    Rails.logger.info "Attempting to authenticate #{username} with #{password}"
    user = find_by_username username
    Rails.logger.info "Found user #{user}"
    Rails.logger.info "Comparing password hashes: #{user.password_hash} and #{BCrypt::Engine.hash_secret (password, user.password_salt)}"
    if user && user.password_hash == BCrypt::Engine.hash_secret (password, user.password_salt)
      user
    else
      nil
    end
  end
end
