class UserMailer < ActionMailer::Base
  
  def registration_request(user)
    @user = user
    mail(
      to: "chantalethenri@abriva.net", 
      from: user.email, 
      return_path: user.email,
      reply_to: user.email,
      subject: "requete d'activation pour le site Chantal et Henri"
    )
  end
  
  def registration_confirmation(user)
    @user = user
    mail(
      from: "chantalethenri@abriva.net", 
      to: user.email, 
      return_path: "chantalethenri@abriva.net",
      reply_to: "chantalethenri@abriva.net",
      subject: "Activation du compte sur le site Chantal et Henri"
    )
  end
  
  def reservation_confirmation(user)
    @user = user
    mail(
      from: "chantalethenri@abriva.net", 
      to: user.email, 
      return_path: "chantalethenri@abriva.net",
      reply_to: "chantalethenri@abriva.net",
      subject: "Reservation chambres au chateau"
    )
  end
  
  def send_email(email)
    @email = email
    cci = email.cci ? email.to.receivers + "," + email.cci : email.to.receivers
    mail(
      from: "chantalethenri@abriva.net", 
      cci: cci,
      to: "chantalethenri@abriva.net, #{email.cc}",
      return_path: "chantalethenri@abriva.net",
      reply_to: "chantalethenri@abriva.net",
      subject: email.subject
    )
  end
end
