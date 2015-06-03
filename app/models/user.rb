class User < ActiveRecord::Base
  has_many :tasks
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :password,
            presence: true,
            confirmation: true
  before_save :digest_password

  def self.authenticate(email, password)
    where(email: email, password: Digest::SHA1.hexdigest(password)).first
  end

  private

  def digest_password
    self.password = Digest::SHA1.hexdigest(self.password)
  end
end
