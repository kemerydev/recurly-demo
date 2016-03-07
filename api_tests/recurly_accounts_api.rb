require 'net/http'
require 'json'
require 'recurly'
require 'rspec'
require 'nokogiri'

require_relative 'api_config'

describe 'recurly accounts api' do
  context '"create a new account with the client library"' do
    @account_code = 'RecurlyAuto' + rand.to_s[2..6]
    account = Recurly::Account.create(
      :account_code => @account_code,
      :email        => 'fulvius@gmail.com',
      :first_name   => 'Kevin',
      :last_name    => 'Emery_API_' + @account_code
    )
  end

  context '"use the api to confirm the new account is present"' do
    url = "https://kemery.recurly.com/v2/accounts/#{@account_code}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    doc = Nokogiri::XML(response)

    # validation on the response goes here
    fail "account #{@account_code} was not present in the API repsonse" unless doc.at_xpath('//account/account_code').content.eql? @account_code
  end
end
