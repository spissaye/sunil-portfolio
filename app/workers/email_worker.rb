class EmailWorker
  include Sidekiq::Worker

  def perform(contact_id)
    puts "="*20
    contact = Contact.find(contact_id)
    puts contact.email
    ContactMailer.contact_mail(contact).deliver
  end
end
