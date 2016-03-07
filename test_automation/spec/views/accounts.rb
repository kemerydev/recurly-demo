require_relative '../spec_helper'
require 'pry'
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

      it '"correct number of accounts are being displayed"' do
      
      end
    end

    def do_login
      login_page = LoginPage.new(@browser.window)
      login_page.goto

      login_page.user_email = @login_credentials.email
      login_page.user_password = @login_credentials.password
      login_page.submit_button

      login_page
  end
  end
end
