class HomeController < ApplicationController

	def index
		@contact = Contact.new
	end

	def contact
		@contact = Contact.new(contact_params)
		@contact.save
    EmailWorker.perform_async(@contact)
		render json: @contact
	end

	private

	def contact_params
		params.require(:contact).permit(:name, :email, :subject, :message)
	end

end
