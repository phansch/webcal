# From http://stackoverflow.com/a/12109098 & modified
module Tokenable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_token
  end

  protected

  def generate_token
    self.token_write = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token_write: random_token)
    end
      self.token_read = token_write[0..12]
  end


#  def generate_read_token
#    self.token_read = loop do
#      random_token = SecureRandom.urlsafe_base64(nil, false)
#      break random_token unless self.class.exists?(token_read: random_token)
#    end
#  end

  def generate_write_token
    self.token_write = loop do
      break random_token unless token_exists?(random_token)
    end
  end

  def token_exists?(token)
    self.class.exists?(token_read: token) && self.class.exists?(token_write: token)
  end

  def random_token
    SecureRandom.urlsafe_base64(nil, false)
  end
end
