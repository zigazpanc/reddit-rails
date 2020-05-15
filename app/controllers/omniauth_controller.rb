class OmniauthController < ApplicationController
    def facebook
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @account = Account.from_omniauth(request.env["omniauth.auth"])
    
        if @account.persisted?
          sign_in_and_redirect @account
          
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_account_registration_url
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
