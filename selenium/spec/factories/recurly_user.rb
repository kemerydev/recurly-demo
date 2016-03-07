FactoryGirl.define do
  factory :recurly_user, :class => RecurlyUser do
    trait :login_credentials do
       email 'fulvius@gmail.com'
       password 'recurly2016!'
    end
    trait :user_domain_info do
       username 'kemery'
       user_full_uri { username + '.recurly.com' }
    end
  end
end
