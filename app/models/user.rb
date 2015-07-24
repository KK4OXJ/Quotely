class User < ActiveRecord::Base

  has_secure_password(options = {validations: false})
  has_many :quotes

end
