class Rolodex
	attr_reader :contacts

	def initialize
		@contacts = []
		@id = 1000
	end

	def add_contact(contact)
		contact.id = @id
		# Accessing the id variable within the contact instance of the 
		# Contact class, which has four variables.
		@contacts << contact
		# All four variables stored within the contact variable are 
		# shoveled into the @contacts array.
		@id += 1
	end

	def find(contact_id)
    @contacts.find {|contact| contact.id == contact_id }
  end

  def remove_contact(contact) 
  	@contacts.delete(contact)
  end
end