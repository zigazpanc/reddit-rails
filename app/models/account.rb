class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :subscriptions
  has_many :communities, through: :subscriptions
  has_many :posts
  has_many :comments
  has_many :votes


  def self.new_with_session(params, session)
    super.tap do |account|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        account.email = data["email"] if account.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |account|
      account.email = auth.info.email
      account.password = Devise.friendly_token[0, 20]
      account.first_name = auth.info.name   # assuming the user model has a name
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    account = Account.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless account
        account = Account.create(first_name: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    account
end

  def full_name
    "#{first_name} #{last_name}"
  end

  def upvoted_post_ids
    self.votes.where(upvote: true).pluck(:post_id)
  end

  def downvoted_post_ids
    self.votes.where(upvote: false).pluck(:post_id)
  end
end
