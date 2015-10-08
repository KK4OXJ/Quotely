class User < ActiveRecord::Base

  has_secure_password(options = { validations: false })
  has_many :quotes

  def admin?
    self.role == 'admin'
  end

end
