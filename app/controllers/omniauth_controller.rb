class OmniauthController < ApplicationController
    def facebook
        @account = Account.create_form_provider_data(request.env['omniauth.auth'])
        if @account.persisted?
            sign_in_and_redirect @account
        else
            sign_in_and_redirect @account
        end
    end

    def google_oauth2
        @account = Account.create_form_provider_data(request.env['omniauth.auth'])
        if @account.persisted?
            sign_in_and_redirect @account
        else
            redirect_to  new_account_registration_url
        end
    end

    def failiure
        sign_in_and_redirect @account, skip_jwt: true
    end
end
