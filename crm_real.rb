require "sinatra"
require_relative "contact"

get "/" do
	@crm_app_name = "My CRM"
	erb :index
end

# View all contacts.
get "/contacts" do
	erb :contacts
end

# Add a new contact.
get "/contacts/new" do
	 # erb :new
end