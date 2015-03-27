class User < ActiveRecord::Base
	has_many  :photo
	has_many  :comment
    has_many  :tag
	
	def password_valid?(password)
        return self.password_digest == Digest::SHA1.hexdigest(password + self.salt)
    end

    def password
    	@p1
    end

    def full_name
        return "#{first_name} #{last_name}"
    end

    def password=(password)
    	self.salt = Random.rand.to_s
    	self.password_digest = Digest::SHA1.hexdigest(password + self.salt)
        @p1 = password
    end

    def password_confirmation
        @p2
    end

    def password_confirmation=(password_confirmation)
        @p2 = password_confirmation
    end

    validates :login, uniqueness: true
    validates :first_name, :last_name, :login, :password, :password_confirmation, presence: true
	validates :password, confirmation: true
end
