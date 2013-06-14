class Newsletteremail < ParseResource::Base
	fields :email

	validates_presence_of :email
end
