class HomeController < ApplicationController

	def index
		@contact = Contact.new
	end

	def contact
		@contact = Contact.new(contact_params)
		if verify_recaptcha(model: @contact) && @contact.save
			EmailWorker.perform_async(@contact.id)
			render json: @contact, status: :ok
		else
			puts @contact.errors.inspect
			render json: @contact.errors, status: :unprocessable_entity
		end
	end

	private

	def contact_params
		params.require(:contact).permit(:name, :email, :subject, :message)
	end

end
