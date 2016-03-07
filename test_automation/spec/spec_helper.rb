Dir[File.join(File.dirname(__FILE__), 'support', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'factories', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'pages', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'flows', '*.rb')].each { |file| require file }
module RecurlyTest
  RSpec.configure do |config|
    config.before(:each) do
      @browser = RecurlyBrowser.new
      @browser.start
    end
    config.after(:each) do
      @browser.teardown
    end
  end
end
