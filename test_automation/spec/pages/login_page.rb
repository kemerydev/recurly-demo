require 'page-object'
require 'watir-webdriver'

class LoginPage
  include PageObject

  page_url 'https://app.recurly.com/login'
  
  text_field(:user_email, id: 'user_email')
  text_field(:user_password, id: 'user_password')
  button(:submit_button, id: 'submit_button')
end
