require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	attr_protected :admin, :salt, :banned, :encrypted_password
	attr_accessible :name, :email, :location, :background, :upvotesto, :password, :upvotesfrom 
	has_many :questions
	has_many :answers
	has_many :comments
	validates_uniqueness_of  :name
	validates_presence_of	:email
	
	
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, 	:presence     => true,
							:if => :password_validation_required?,
						:length       => { :within => 6..40 },				
						:confirmation => true
					
	 before_save :encrypt_password	
	
	def password_validation_required?
		encrypted_password.blank? || !password.blank?
	end
	
 def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.putNamesToIds(oldlist,users)		
		uplist = ''
		if !oldlist.nil?
			upsplit = oldlist.split(",")
			for i in 0..(upsplit.length)-1
				if !upsplit[i].nil? 
					if i==0
						uplist = users.find(upsplit[i]).name + ','
					else
						uplist = uplist + ' ' + users.find(upsplit[i]).name + ','
					end
				end
			end
			return uplist.chomp(",")
			else
			return ''
		end
	end
	
  
  def self.has_upvoted(oldstring,needle)
	@found = false
	if !oldstring.nil?
	 @upsplit = oldstring.split(",")
	 
	 for i in 0..@upsplit.length
		puts 'compare ' + @upsplit[i].to_s + ' ' + needle.to_s
		if @upsplit[i].to_s == needle.to_s
			@found = true
			end
	 end
	 end
	 return @found
  end
  
  
  def self.get_down(oldstring,needle)
	if !oldstring.nil?
		sneedle = needle.to_s
		stringindex = oldstring.index(sneedle)
		puts 'get down ' + oldstring + ' ' + sneedle
		puts 'oldstring length ' + oldstring.length.to_s
		puts 'string index ' + stringindex.to_s
		if oldstring.length == 1
			newstring = oldstring.sub(sneedle, '')
			else
			if stringindex > 1
				newstring = oldstring.sub(',' + sneedle, '')
				else
				newstring = oldstring.sub(sneedle + ',', '')
				end
			end
		return newstring
	else
	return ""
	end
  end
  
  
  def self.get_up(oldstring,addon)
	if !oldstring.nil?	
		puts 'get up ' + oldstring + ' ' + addon.to_s
		puts 'oldstring length ' + oldstring.length.to_s
		if oldstring.length > 0
				up = oldstring + ',' + addon.to_s
			else
				up =  addon.to_s
			end
		return up
	else
		return addon.to_s
	end
  end
  
  def has_salt
	!self.salt.nil?
	end
  
	private	
	def encrypt_password
		
		#	self.salt = make_salt unless has_password?(password)
		#	self.encrypted_password = encrypt(password)
			if !has_salt
				self.salt = make_salt
				self.encrypted_password = encrypt(password)
			end
			
		end		
	def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
	
   def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
	
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
	
def self.authenticate(name, submitted_password)
    user = find_by_name(name)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  
end