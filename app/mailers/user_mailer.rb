class UserMailer < ActionMailer::Base
  add_template_helper(ChildProfilesHelper)

  def registration_confirmation(user,subject,body)
    @user = user
    @url = "http://gmail.com"
    mail( from: "d1.diluo.nu", to: user.email, subject: subject ,body: body)
  end

  def send_pdf(dairy, email_id)
    @dairy = dairy
    mail(from: "d1.diluo.nu", :to => email_id, :subject => "awesome pdf, check it")  do |format|
      format.html
      format.pdf do
        attachments["attachement_name.pdf"] =   WickedPdf.new.pdf_from_string( render_to_string(  :pdf => "mypdf",
                                                                    :template => "user_mailer/send_pdf") ,
                                                                    :page_height => '2.7in', :page_width => '2.5in'
        )
      end
    end
  end

  def password_reset(user, type)
    @user = user
    @type = type
    mail(from: "d1.diluo.nu", :to => user.email, :subject => "Password Reset")
  end
end
