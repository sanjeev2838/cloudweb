class UserMailer < ActionMailer::Base
  add_template_helper(ChildProfilesHelper)

  def registration_confirmation(user,subject,body)
    # recipients  user.email
    # from        "office@ezzie.in"
    # subject     subject
    # body        body
    #mail(:from=>"saini.pardeep8@gmail.com",:to => "pardeep@ezzie.in",:subject=>"Password reset")
    @user = user
    @url = "http://gmail.com"
    mail( from: "d1.diluo.nu", to: user.email, subject: subject ,body: body)

  end

  def send_pdf(dairy)
    @dairy = dairy
    mail(from: "d1.diluo.nu", :to => "sanjeevk.impinge@gmail.com", :subject => "awesome pdf, check it")  do |format|
      format.html
      format.pdf do
        attachments["attachement_name.pdf"] =   WickedPdf.new.pdf_from_string( render_to_string(  :pdf => "mypdf",
                                                                    :template => "user_mailer/send_pdf") ,
                                                                    :page_height => '2in', :page_width => '2in'
        )
      end
    end
  end
end
