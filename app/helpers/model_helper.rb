module ModelHelper
	
	def activate
		if not self.active
			self.active = true
			self.save
		end
	end

	def deactivate
		if self.active
			self.active = false
			self.save
		end
	end

end