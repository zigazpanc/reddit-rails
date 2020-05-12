class OmniauthController < ApplicationController
    def facebook
        @account = Account.create_form_provider_data(request.env['omniauth.auth'])
        if @account.presisted?
            sign_in_and_redirect @account
        else

            redirect_to  new_user_registration_url
        end
    end

    def google_oauth2
        @account = Account.create_form_provider_data(request.env['omniauth.auth'])
        if @account.presisted?
            sign_in_and_redirect @account
        else
            redirect_to  new_user_registration_url
        end
    end

    def failiure
        redirect_to new_user_registration_url
    end
end
