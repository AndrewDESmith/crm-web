require "sinatra"
require_relative "contact"

get "/" do
	@crm_app_name = "My CRM"
	erb :index
end

# View all contacts.
get "/contacts" do
	@contacts = []
	@contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
	erb :contacts
end

# Add a new contact.
get "/contacts/new" do
	 # erb :new
end