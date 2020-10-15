# require 'support/factory_bot'
FactoryBot.define do
    factory :user do
        username { "Andy" }
        password { "starwars" }
        # session_token { SecureRandom::urlsafe_base64 }
        # association :location, factory: :location
    end
end