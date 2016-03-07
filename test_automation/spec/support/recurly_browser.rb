require 'selenium-webdriver'
require 'watir-webdriver'
class RecurlyBrowser
  def window
    @browser
  end
  def start
    @firefox_driver = Selenium::WebDriver.for :firefox
    @browser = Watir::Browser.new(@firefox_driver)
  end
  def teardown
    @browser.close
    @browser.quit
  end
end
