class ContactMailer < ActionMailer::Base
  def contact_mail(contact)
    puts "*"*20
    puts contact.inspect
    @contact = contact
    mail( to: "sunil.pissaye@gmail.com", from: "SP Website <noreply@meetsunil.com>", reply_to: "SP Website <noreply@meetsunil.com>", subject: "Contact on SP Website", template_name: 'contact_mailer', template_path: "mailers")
  end
end