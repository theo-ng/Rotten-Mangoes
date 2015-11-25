class UserMailer < ApplicationMailer
  default from: 'notifications@mangos.com'
 
  def user_deleted(user)
    @user = user
    @url  = 'localhost:3000/movies'
    mail(to: @user.email, subject: 'User Deleted by Admin')
  end
end
