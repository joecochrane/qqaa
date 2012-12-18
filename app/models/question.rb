class Question < ActiveRecord::Base
    has_many :answers
	has_many :comments
    belongs_to :user
	attr_accessible  :id, :tags, :user_id , :text, :qcat
	validates_presence_of	:text
	
	default_scope :order => 'questions.created_at DESC'
	
	
	def setuserid
		
	end
	
	def self.search(qcatparam)
		if search
			where('qcat = ?', qcatparam)
			puts 'yes parameters'
		else
			all
			puts 'no parameters'
			
		end
	end
	
	  def self.putTextsToIds(oldlist,questions)		
		uplist = ''
		if !oldlist.nil?
			upsplit = oldlist.split(",")
			for i in 0..(upsplit.length)-1
				if !upsplit[i].nil? 
					if i == 0
						uplist = questions.find(upsplit[i]).text + ','
					else
						uplist = uplist + ' ' + questions.find(upsplit[i]).text + ','
					end
				end
			end
			return uplist.chomp(",")
			else
			return ''
		end
	end

	

	
	def self.cats()
		cats = {'1' => 'first', '2' => 'correct' , '3' => 'conservative' , '4' => 'liberal', '5' => 'mainstream', '6' => 'conspiracy_theory', '7' => '14', '8' => 'old_guy'  }
	end			
	
	
	
	def self.qcats()
		qcats = {'1' => 'all', '2' => 'food', '3' => 'politics' , '4' => 'comedy' , '5' => 'something else'}
	end
	def self.noallqcats()
		qcats = { '2' => 'food', '3' => 'politics' , '4' => 'comedy' , '5' => 'something else'}
	end
	
end	
	
