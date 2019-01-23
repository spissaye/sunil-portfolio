class EmailWorker
  include Sidekiq::Worker

  def perform(contact)
    ContactMailer.contact_mail(contact)
  end
end
