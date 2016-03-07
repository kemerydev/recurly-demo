class RecurlyUser
  @email = String.new
  @password = String.new
  @username = String.new
  @user_full_uri = String.new
  attr_accessor :email, :password, :username, :user_full_uri

  def email=(email)
    @email = email
  end
  def password=(password)
    @password = password
  end
  def username=(username)
    @username = username
  end
  def user_full_uri=(user_full_uri)
    @user_full_uri = user_full_uri
  end
end
