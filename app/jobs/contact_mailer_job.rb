class ContactMailerJob
  @queue = :other_mailer

  def self.perform(contact_id)
    @contact = Contact.find(contact_id)
    ContactMailer.contact_mail(@contact).deliver
  end
end