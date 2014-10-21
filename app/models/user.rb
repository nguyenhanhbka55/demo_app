class User < ActiveRecord::Base
	attr_accessor :password
	#attr_accessible :password, :email
	#validates_confirmation_password :password
	EMAIl_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates :email , format: { with: EMAIl_REGEX}, uniqueness: {case_sensitive: false}
	#validates :name, :length => {:maximum => 50}, presence: true
	validates :email, :length => {:within => 5..30}, presence: true
	validates :password_confirmation, presence: true
	validates :password, :confirmation => true , presence: true

	before_save :encrypt_password
	
	def encrypt_password
		self.password_salt = BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	end

	def self.authenticate(email,password)
		user = User.where(email: email).first
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end
end
