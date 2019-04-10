class EmailWorker
  include Sidekiq::Worker

  def perform(contact_id)
    contact = Contact.find(contact_id)
    ContactMailer.contact_mail(contact).deliver
  end
end
