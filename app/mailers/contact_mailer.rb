class ContactMailer < ActionMailer::Base
  def contact_mail(contact)
    @contact = contact
    mail( to: "sunil.pissaye@gmail.com", from: "SP Website <noreply@meetsunil.com>", reply_to: "SP Website <noreply@meetsunil.com>", subject: "Contact on SP Website", template_name: 'contact_mailer', template_path: "mailers")
  end
end