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
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @account = Account.from_omniauth(request.env['omniauth.auth'])
  
        if @Account.persisted?
          
          sign_in_and_redirect @account
        else
          session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
          redirect_to new_account_registration_url
        end
    end

    def failiure
        sign_in_and_redirect @account, skip_jwt: true
    end
end
