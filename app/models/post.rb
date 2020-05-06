class Post < ApplicationRecord
    belongs_to :account
    belongs_to :community
    has_one_attached :image
    validates_presence_of :title, :body, :account_id, :community_id
    has_many :comments

    def score
        #razlika med upvoti in downvoti
        if self.upvotes > 0 || self.downvotes > 0
            self.upvotes > 0 ? (self.upvotes - self.downvotes) : (self.downvotes * -1)
        else
            0
        end
    end
end