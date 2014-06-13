require "sinatra"
require_relative "contact"
require_relative "rolodex"
require "data_mapper"

DataMapper.setup(:deafault, "sqlite3:database.sqlite3")
# sqlite3:the database we are using, database.sqlite3 the file.

# To enable access to Rolodex from each action in Sinatra.
@@rolodex = Rolodex.new

get "/" do
	@crm_app_name = "My CRM"
	erb :index
end

# View all contacts.
get "/contacts" do
	erb :contacts
end

post "/contacts" do
	new_contact = Contact.new(params[:first_name], params[:last_name], 
		params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect to("/contacts")
end

# Add a new contact.
get "/contacts/new" do
	 erb :new_contact
end

get "/contacts/search_contact" do
	erb :search_contact
end

post "/contacts/do_search" do
	puts params
	@contact = @@rolodex.contacts.find { |contact| contact.first_name == params[:first_name] && contact.last_name == params[:last_name] }
	erb :show_contact
end

get "/contacts/edit" do
	erb :show_contact
	# @contact = @@rolodex.find_contact(params[:id].to_i)
	# if @contact
	# 	erb :edit_contact
	# else
	# 	raise Sinatra::NotFound
	# end
end

get "/contacts/:id" do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

put "/contacts/:id" do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

delete "/contacts/:id" do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		@@rolodex.remove_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end