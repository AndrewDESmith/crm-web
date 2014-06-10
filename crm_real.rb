require "sinatra"
require_relative "contact"
require_relative "rolodex"

@@rolodex = Rolodex.new
# To enable access to Rolodex from each action in Sinatra.

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
	 erb :new_contact
end

post "/contacts" do
	new_contact = Contact.new(params[:first_name], params[:last_name], 
		params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect to("/contacts")
end