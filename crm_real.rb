require "sinatra"
require_relative "rolodex"
require "data_mapper"

# sqlite3:the database we are using, database.sqlite3 the file.
DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	# A module is a just file with a bunch of methods in it.
	include DataMapper::Resource

	# Properties automatically set up getter and setter methods.
	# Serial represents an Integer that automatically increments.
	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
end

# .finalize used after the DataMapper resources are defined.
DataMapper.finalize
# .auto_upgrade takes care of effecting any changes to the
# underlying structure of the tables or columns.
DataMapper.auto_upgrade!

# To enable access to Rolodex from each action in Sinatra.
@@rolodex = Rolodex.new

get "/" do
	@crm_app_name = "My CRM"
	erb :index
end

# View all contacts.
get "/contacts" do
	@contacts = Contact.all
	erb :contacts
end

post "/contacts" do
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note],
	)
	redirect to ("/contacts")
end

put "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	@contact.update(:first_name => params[:first_name], :last_name => params[:last_name], 
	:email => params[:email], :note => params[:note])
	redirect to ("/contacts")
	# erb :show_contact
end

delete "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	@contact.destroy!
	redirect to ("/contacts")
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

get "/contacts/:id/edit" do
	@contact = Contact.get(params[:id].to_i)
	erb :edit_contact
end

 
get "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end