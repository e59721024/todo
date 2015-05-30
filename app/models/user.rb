class User < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :password,
            presence: true,
            confirmation: true
  before_create :digest_password

  def self.authenticate(email, password)
    where(email: email, password: Digest::SHA1.hexdigest(password)).first
    # binding.pry
    # where(email: email, password: password).first
  end

  private

  def digest_password
    self.password = Digest::SHA1.hexdigest(self.password)
  end
end
