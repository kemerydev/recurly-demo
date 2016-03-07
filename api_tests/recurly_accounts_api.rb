require 'net/http'
require 'json'
require 'recurly'
require 'rspec'
require_relative 'api_config'

$account_code = 'RecurlyAuto' + rand.to_s[2..6]

describe 'recurly accounts api' do
  it '"create a new account with the client library"' do
    account = Recurly::Account.create(
      :account_code => $account_code,
      :email        => 'fulvius@gmail.com',
      :first_name   => 'Kevin',
      :last_name    => 'Emery_API_' + $account_code
    )
  end

  it '"use the api to confirm the new account is present"' do
    begin
      account = Recurly::Account.find $account_code
    rescue Recurly::Resource::NotFound => e
      fail "account code #{$account_code} was not found by the API with exception text: #{e.message}"
    end

    fail "Account #{account.account_code} was returned by the api, expecting #{$account_code}" unless account.account_code.eql?($account_code)

  end
end
