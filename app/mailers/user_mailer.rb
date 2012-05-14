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
end
