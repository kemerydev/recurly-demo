require_relative '../spec_helper'
module RecurlyTest
  describe '/accounts' do
    context '"accounts page for a new trial account"' do

      before(:all) do
        @login_credentials = FactoryGirl.build :recurly_user, :login_credentials
        @user_domain_info = FactoryGirl.build :recurly_user, :user_domain_info
      end

      it '"page gets displayed properly"' do      
        do_login

        expected_user_url = 'https://' +  @user_domain_info.user_full_uri
        fail "Expected the the domain URL to begin with '#{expected_user_url}' after logging in the user '#{@user_domain_info.username}' with email " \
             "'#{@login_credentials.email}' but instead the URL is '#{@browser.window.url}'" unless @browser.window.url.start_with?(expected_user_url)

        fail "Sidebar div with class 'Site-sidebar' was not visible at #{@browser.window.url}" unless @browser.window.div(:class => 'Site-sidebar').visible?
        fail "Content div with class 'Site-content' was not visible at #{@browser.window.url}" unless @browser.window.div(:class => 'Site-content').visible?
      end

      # without the page-object gem, additional Watir element locators are hard-coded into the spec below using Xpath
      # hard-coded locators like this are less flexible, but quicker and easier to write, and they may be easier for other automation testers to read and interpret
      it '"correct number of accounts are being displayed"' do
        do_login

        @browser.window.a(href: '/accounts').click # hard-coded locators like might be more difficult to maintain outside of a page object

        expected_accounts_url = 'https://' + @user_domain_info.user_full_uri + '/accounts'
        fail "Expected the the domain URL to be '#{expected_accounts_url}' for user '#{@user_domain_info.username}' with email " \
             "'#{@login_credentials.email}' but instead the URL is '#{@browser.window.url}'" unless @browser.window.url.eql? expected_accounts_url

        # relative xpaths and matches to CSS class can be brittle unless they are written to a standard CSS and DOM structure that is consistent
        account_table_rows_xpath = "//div[@class='Page-main']/descendant::div[contains(@class,'Table--equallySpaced')]/div[@class='Table-body']/a"
        account_row_count = @browser.window.links(xpath: account_table_rows_xpath).count
        
        account_pagination_xpath = "//div[@class='Page-main']/descendant::div[@class='Pagination-left']"
        pagination_text = @browser.window.div(xpath: account_pagination_xpath).text

        fail "Pagination subtext #{pagination_text} was either missing from the accounts page," \
             "or does not begin with 'Displaying'" unless pagination_text.start_with? 'Displaying'

        pagination_text_number = pagination_text.split[pagination_text.split.index('accounts')-1].to_i
        fail "Pagination subtext #{pagination_text} indicates #{pagination_text_number.to_s} accounts but there are #{account_row_count.to_s} rows in the" \
             "Accounts table at #{@browser.window.url}" unless pagination_text_number == account_row_count
      end
    end

    # the page-object gem automatically calls the watir-webdriver methods to send_keys and click on the elements defined in spec/pages/login_page.rb
    def do_login
      login_page = LoginPage.new(@browser.window)
      login_page.goto

      login_page.user_email = @login_credentials.email # page-object automatically calls the watir-webdriver 'set' method when using =
      login_page.user_password = @login_credentials.password
      login_page.submit_button # page-object sees that it's a button and automatically clicks it
    end
  end
end
